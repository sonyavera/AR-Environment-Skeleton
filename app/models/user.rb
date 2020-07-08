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

    
    # def avg_score_helper(date) #already working
    #         counter = 14
    #         sum = 0
    #     while counter > 0
    #         sum += score_by_date(date-counter)
    #         counter -= 1
    #     end
    #         avg_score = sum/14
    # end


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
    
    def report_avg_score
        if retrieve_avg_score < 5
            puts "Your risk level is GREEN"
        elsif retrieve_avg_score >= 5 && retrieve_avg_score < 6
            puts "Your risk level is YELLOW"
        else
            puts "Your risk level is RED"
        end
    end

    def update_most_recent_log(new_act_type)
        logs_by_date(Date.today).last.activity_type = new_act_type
    end

    def delete_most_recent_log
        logs_by_date(Date.today).last.destroy
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