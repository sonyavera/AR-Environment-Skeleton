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

aclog5 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 1)
aclog6 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 2)
aclog7 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 3)
aclog8 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 4)
aclog9 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 5)
aclog10 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 6)
aclog11 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 7)
aclog12 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 8)
aclog13 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 9)
aclog14 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 10)
aclog15 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 11)
aclog16 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 12)
aclog17 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 13)
aclog18 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 14)

