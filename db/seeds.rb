User.delete_all
ActivityType.delete_all
ActivityLog.delete_all

user1 = User.create(name: "Stephanie")
user2 = User.create(name: "Maurice")
user3 = User.create(name: "Jane")
user4 = User.create(name: "Rebecca") # has no logs


actype1 = ActivityType.create(name: "Indoor - under 15 people", risk_score: 3)
actype2 = ActivityType.create(name: "Indoor - over 15 people", risk_score: 6)
actype3 = ActivityType.create(name: "Outdoor - under 15 people", risk_score: 1)
actype4 = ActivityType.create(name: "Outdoor - over 15 people", risk_score: 2)
actype5 = ActivityType.create(name: "Public transportation - under 15 min", risk_score: 6)
actype6 = ActivityType.create(name: "Public transportation - over 15min", risk_score: 8)
actype7 = ActivityType.create(name: "Self quarantine, no activities", risk_score: 0)



aclog1 = ActivityLog.create(user: user1, activity_type: actype1, date: Date.new(2020,7,8))
aclog2 = ActivityLog.create(user: user2, activity_type: actype3, date: Date.new(2020,7,8))
aclog3 = ActivityLog.create(user: user3, activity_type: actype1, date: Date.new(2020,7,8))
aclog4 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.new(2020,7,8))
aclog5 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.new(2020,7,7))
aclog6 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.new(2020,7,5))
#user1 should have a total score of 21, an average score of 1.something




# aclog7 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 3)
# aclog8 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 4)
# aclog9 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 5)
# aclog10 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 6)
# aclog11 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 7)
# aclog12 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 8)
# aclog13 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 9)
# aclog14 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 10)
# aclog15 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 11)
# aclog16 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 12)
# aclog17 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 13)
# aclog18 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.yesterday - 14)

