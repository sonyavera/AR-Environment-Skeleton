User.delete_all
ActivityType.delete_all
ActivityLog.delete_all

user1 = User.create(name: "Stephanie")
user2 = User.create(name: "Maurice")
user3 = User.create(name: "Jane")

actype1 = ActivityType.create(name: "Biking", risk_score: 1)
actype2 = ActivityType.create(name: "Shopping", risk_score: 5)
actype3 = ActivityType.create(name: "Party!", risk_score: 10)
actype4 = ActivityType.create(name: "Stadium dance", risk_score: 9999999)


aclog1 = ActivityLog.create(user: user1, activity_type: actype1, date: Date.new(2020,07,07))
aclog2 = ActivityLog.create(user: user2, activity_type: actype3, date: Date.yesterday)
aclog3 = ActivityLog.create(user: user3, activity_type: actype1, date: "2020-07-07")
aclog4 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.new(2020,07,07))
aclog5 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday)