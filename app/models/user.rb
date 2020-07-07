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
    def my_activity_types
        my_logs.map {|log| log.activity_type}
    end

    #sums risk scores for all of users activity_types - probably moot
    def sum_score
        my_activity_types.sum{|actype| actype.risk_score}
    end

    # gives all logs on a given day
    def logs_by_date(date)
        my_logs.select{|log| log.date == date}
    end

    # gives all activities on a given day
    def activity_type_by_date(date)
        logs_by_date(date).map {|log| log.activity_type}
    end

    #sums scores on a given day
    def score_by_date(date)
        activity_type_by_date(date).sum{|actype| actype.risk_score}
    end

    
    def avg_score (date)
        fourteen_days_ago = date -14
        sum_scores = 0
    
        (date..fourteen_days_ago).each do |day|
            binding.pry
            #puts score_by_date(day)
        end

        # until !date > fourteen_days_ago
        #     if score_by_date(date) == nil 
        #         sum_scores += 0
        #     else
        #         sum_scores += score_by_date(date)
        #     end
        #     date - 1
        # end
        # avg_score = sum_scores / 14
        # loop through each day until day = today-14
        # for each day call score_by_date
        # and then go back one more day 
        
    end

end