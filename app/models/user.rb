require 'pry'
require 'date'
require 'colorize'

class User < ActiveRecord::Base
    has_many :activity_logs
    has_many :activity_types, through: :activity_logs


    #returns array of all user's logs (**this is actually just built into AR)
    def my_logs
        ActivityLog.all.select {|log| log.user == self}
    end

    #returns array of all user's activitytype instances - (**this is actually just built into AR)
    def my_activity_types_by_log
        my_logs.map {|log| log.activity_type}
    end

    #sums risk scores for all of users activity_types (total not for any time period - to be used for stretch features possibly)
    def sum_score
        my_activity_types_by_log.sum{|actype| actype.risk_score}
    end


    # gives all ActivityLogs of a user on a given day
    def logs_by_date(date)
        my_logs.select{|log| log.date == date}
    end

    # gives all ActivityTypes of a user on a given day
    def activity_type_by_date(date)
        logs_by_date(date).map {|log| log.activity_type}
    end

    #returns user's cumulative risk score (of all logs) on a given date
    def score_by_date(date)
        activity_type_by_date(date).sum{|actype| actype.risk_score}
    end


    def risk_level_by_date(date)
        if score_by_date(date) < 5
            risk_level = "Green"
        elsif score_by_date(date) >= 5 && retrieve_avg_score < 8
            risk_level = "Yellow"
        else
            risk_level = "Red"
        end
        risk_level
    end


    def num_of_consecutive_days_logged
        num_of_consecutive_days_logged = 0
        while 
            logs_by_date(Date.today-num_of_consecutive_days_logged).length != 0 
            num_of_consecutive_days_logged +=1
        end
        num_of_consecutive_days_logged
    end
        
    def avg_score_helper(date)
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


    def report_risk_level
        if num_of_consecutive_days_logged == 0
            puts "\nYou have not logged any activities today. In order to see your risk level today, you must log your activities."
        elsif num_of_consecutive_days_logged >= 14
            if retrieve_avg_score < 5
                puts "\nYour risk level is GREEN.".green
            elsif retrieve_avg_score >= 5 && retrieve_avg_score < 8
                puts "\nYour risk level is YELLOW.".yellow
            else
                puts "\nYour risk level is RED.".red
            end
        else
            if retrieve_avg_score < 5
                puts "\nYour risk level is GREEN. This your behavior has been low risk. You've logged your activities for #{num_of_consecutive_days_logged} day(s). \n\nFor the most accurate risk level, try to log your activities (or lack thereof) for 14 consecutive days, which is the incubation period for COVID-19.".green
            elsif retrieve_avg_score >= 5 && retrieve_avg_score < 8
                puts "\nYour risk level is YELLOW. This means your behavior has been medium risk. You've logged your activities for #{num_of_consecutive_days_logged} day(s). \n\nFor the most accurate risk level, try to log your activities (or lack thereof) for 14 consecutive days, which is the incubation period for COVID-19.".yellow
            else
                puts "\nYour risk level is RED. This means your behavior has been high risk. You've logged your activities for #{num_of_consecutive_days_logged} day(s). \n\nFor the most accurate risk level, try to log your activities (or lack thereof) for 14 consecutive days, which is the incubation period for COVID-19.".red
            end
        end
    end

    def risk_level_color
        if logged_today?
            if retrieve_avg_score < 5
                risk_level = "GREEN"
            elsif retrieve_avg_score >= 5 && retrieve_avg_score < 8
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
            puts "\nIn order to get recommendations for your behavior, please log your activities to generate a risk level."
        elsif risk_level_color == "GREEN"
            puts "\nYour current risk level is GREEN, which means your behavior has been low-risk on average. \n\nTaking precautions such as wearing a face covering and practicing social distancing, you can feel safe visiting with \nsmall groups of friends and family outdoors, or in well-ventilated indoor spaces for brief periods of time.".green
        elsif risk_level_color == "YELLOW"
            puts "\nYour current risk level is YELLOW, which means your behavior has been medium-risk on average. \n\nBe diligent about using a face covering and practicing social distancing to avoid potentially infecting others. \nTry to limit time on public transportation and indoor gatherings.".yellow
        else
            puts "\nYour current risk level is RED, which means your behavior has been high-risk on average. \n\nYou should avoid public transportation, social gatherings, and consider getting tested for COVID-19 (it's free!). \nAim to reduce your risky behavior for at least 2 weeks before visiting with any vulnerable family or friends.".red
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

    def show_trend
        if logged_today_or_yesterday?
            counter = 0
            trend_string = " "
            until counter == num_of_consecutive_days_logged
                trend_string += "Date: #{Date.today-counter} --> Risk Level: #{risk_level_by_date(Date.today-counter)} \n"
                counter += 1
            end
            puts trend_string.strip
        else
            puts "\nYou must log your activities in order to see your behavior trend."
        end
    end

    def logged_today_or_yesterday?
        num_of_consecutive_days_logged  != 0
    end

    def logged_today?
        logs_by_date(Date.today).count > 0
    end

    
end

