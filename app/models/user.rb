require 'pry'
require 'date'

class User < ActiveRecord::Base
    has_many :activity_logs
    has_many :activity_types, through: :activity_logs


    #returns array of all user's logs
    def my_logs
        ActivityLog.all.select {|log| log.user == self}
    end

    #returns array of all user's activitytype instances
    def my_activity_types_by_log
        my_logs.map {|log| log.activity_type}
    end

    #sums risk scores for all of users activity_types - probably moot
    def sum_score
        my_activity_types_by_log.sum{|actype| actype.risk_score}
    end


    # gives all logs of a user on a given day
    def logs_by_date(date)
        my_logs.select{|log| log.date == date}
    end

    # gives all activities on a given day
    def activity_type_by_date(date)
        logs_by_date(date).map {|log| log.activity_type}
    end

    def score_by_date(date)
        activity_type_by_date(date).sum{|actype| actype.risk_score}
    end


    def num_of_consecutive_days_logged
        num_of_consecutive_days_logged = 0
        while 
            logs_by_date(Date.today-num_of_consecutive_days_logged).length != 0 
            num_of_consecutive_days_logged +=1
        end
        num_of_consecutive_days_logged
    end
        
    def avg_score_helper(date) #already works
        counter = num_of_consecutive_days_logged
        sum = 0
    while counter > 0
        sum += score_by_date(date-counter)
        counter -= 1
    end
        avg_score = sum/num_of_consecutive_days_logged
    end


    def retrieve_avg_score
        if score_by_date(Date.today) == 0
            avg_score_helper(Date.today)
        else
            avg_score_helper(Date.today+1)
        end
    end


    def report_risk_level #not tested yet with new if statement
        if num_of_consecutive_days_logged == 0
            puts "You have not logged any activities today or yesterday. In order to see your risk level today, you must log your activities."
        elsif num_of_consecutive_days_logged >= 14
            if retrieve_avg_score < 5
                puts "Your risk level is GREEN."
            elsif retrieve_avg_score >= 5 && retrieve_avg_score < 6
                puts "Your risk level is YELLOW."
            else
                puts "Your risk level is RED."
            end
        else
            if retrieve_avg_score < 5
                puts "Your risk level is GREEN. You've logged your activities for #{num_of_consecutive_days_logged} day(s). For the most accurate risk level, try to log your activities (or lack thereof) for 14 consecutive days, which is the incubation period for COVID-19."
            elsif retrieve_avg_score >= 5 && retrieve_avg_score < 6
                puts "Your risk level is YELLOW. You've logged your activities for #{num_of_consecutive_days_logged} day(s). For the most accurate risk level, try to log your activities (or lack thereof) for 14 consecutive days, which is the incubation period for COVID-19."
            else
                puts "Your risk level is RED. You've logged your activities for #{num_of_consecutive_days_logged} day(s). For the most accurate risk level, try to log your activities (or lack thereof) for 14 consecutive days, which is the incubation period for COVID-19."
            end
        end
    end

    def risk_level_color
        if logged_today?
            if retrieve_avg_score < 5
                risk_level = "GREEN"
            elsif retrieve_avg_score >= 5 && retrieve_avg_score < 6
                risk_level = "YELLOW"
            else
                risk_level = "RED"
            end
            risk_level
        else
            nil
        end
    end

    def give_recs 
        if risk_level_color == nil
            puts "In order to get recommendations for your behavior, please log your activities to generate a risk level."
        elsif risk_level_color == "GREEN"
            puts "Your current risk level is GREEN, which means your behavior has been low-risk on average. Taking precautions such as wearing a face covering and practicing social distancing, you can feel safe visiting with small groups of friends and family outdoors, or in well-ventilated indoor spaces for brief periods of time."
        elsif risk_level_color == "YELLOW"
            puts "Your current risk level is YELLOW, which means your behavior has been medium-risk on average. Be diligent about using a face covering and practicing social distancing to avoid potentially infecting others. Try to limit time on public transportation and indoor gatherings."
        else
            puts "Your current risk level is RED, which means your behavior has been high-risk on average. You should avoid public transportation, social gatherings, and consider getting tested for COVID-19 (it's free!). Aim to reduce your risky behavior for at least 2 weeks before visiting with any vulnerable family or friends."
        end
    end

    def update_most_recent_log(new_act_type)
        logs_by_date(Date.today).last.update(activity_type: new_act_type)
    end

   
    def delete_most_recent_log
        logs_by_date(Date.today).last.destroy
    end

    def report_last_activity_type
            logs_by_date(Date.today).last.activity_type.name.to_s
    end

    def show_trend #how will we seed the app so that this works properly in cli
        if logged_today_or_yesterday?
            counter = 0
            trend_string = " "
            until counter == num_of_consecutive_days_logged
                trend_string += "Date:#{Date.today-counter} Score:#{score_by_date(Date.today-counter)} \n"
                counter += 1
            end
            puts trend_string.strip
        else
            puts "You must log your activities in order to see your behavior trend."
        end
    end

    def logged_today_or_yesterday?
        num_of_consecutive_days_logged  != 0
    end

    def logged_today?
        logs_by_date(Date.today) != []
    end

    

end





# come back to it as stretch goal - delees all logs on a given day
    # def delete_log(today_date) #continue with this method on wednesday
    #     #binding.pry
    #     logs_today = logs_by_date(today_date)
    #     binding.pry
    #     "last line"
    #     #logs_today.where(date == today_date).destroy_all
    # end





    # def delete_log(activity_type_id, date)
    #     User.logs_by_date(date).map {|log| log.activity_type_id}
    #         User.where(log.activity_type_id == activity_type_id).destroy_all
    #         binding.pry
    # end