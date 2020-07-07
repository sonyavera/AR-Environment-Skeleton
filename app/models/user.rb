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


    # gives all logs on a given day
    def logs_by_date(date)
        my_logs.select{|log| log.date == date}
    end

    # gives all activities on a given day
    def activity_type_by_date(date)
        logs_by_date(date).map {|log| log.activity_type}
    end

    #sums scores on a given day #not working!
    def score_by_date(date)
        activity_type_by_date(date).sum{|actype| actype.risk_score}
    end

    
    def last_fourteen_days_score_avg(date) #does not include today
            counter = 14
            sum = 0
        while counter > 0
            sum += score_by_date(date-counter)
            counter -= 1
        end
            avg_score = sum/14
    end
    
    
    def avg_score(date)
        if score_by_date(date) == 0
            last_fourteen_days_score_avg(date)
        else
            last_fourteen_days_score_avg(date+1)
        end
    end


    def delete_log(date) #continue with this method on wednesday
        #User.where(self.activity_logs.date == date).destroy_all
    end








end











    # def delete_log(activity_type_id, date)
    #     User.logs_by_date(date).map {|log| log.activity_type_id}
    #         User.where(log.activity_type_id == activity_type_id).destroy_all
    #         binding.pry
    # end