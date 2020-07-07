class ActivityType < ActiveRecord::Base
    has_many :activity_logs
    has_many :users, through: :activity_logs
end