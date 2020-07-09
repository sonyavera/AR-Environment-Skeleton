User.delete_all
ActivityType.delete_all
ActivityLog.delete_all


actype1 = ActivityType.create(name: "Indoor - under 15 people", risk_score: 3)
actype2 = ActivityType.create(name: "Indoor - over 15 people", risk_score: 6)
actype3 = ActivityType.create(name: "Outdoor - under 15 people", risk_score: 1)
actype4 = ActivityType.create(name: "Outdoor - over 15 people", risk_score: 2)
actype5 = ActivityType.create(name: "Public transportation - under 15 min", risk_score: 6)
actype6 = ActivityType.create(name: "Public transportation - over 15min", risk_score: 8)
actype7 = ActivityType.create(name: "Self quarantine, no activities", risk_score: 0)

diligient_user = User.create(name: "Pablo")
forgetful_user = User.create(name: "Teresa")

al1 = ActivityLog.create(user: diligient_user, activity_type: actype1, date: Date.new(2020,6,26))
al2 = ActivityLog.create(user: diligient_user, activity_type: actype2, date: Date.new(2020,6,26))
al3 = ActivityLog.create(user: diligient_user, activity_type: actype3, date: Date.new(2020,6,26))
al4 = ActivityLog.create(user: diligient_user, activity_type: actype4, date: Date.new(2020,6,27))
al5 = ActivityLog.create(user: diligient_user, activity_type: actype2, date: Date.new(2020,6,28))
al6 = ActivityLog.create(user: diligient_user, activity_type: actype1, date: Date.new(2020,6,29))
al7 = ActivityLog.create(user: diligient_user, activity_type: actype3, date: Date.new(2020,6,29))
al8 = ActivityLog.create(user: diligient_user, activity_type: actype7, date: Date.new(2020,6,30))
al9 = ActivityLog.create(user: diligient_user, activity_type: actype2, date: Date.new(2020,7,1))
al10 = ActivityLog.create(user: diligient_user, activity_type: actype5, date: Date.new(2020,7,1))
al11 = ActivityLog.create(user: diligient_user, activity_type: actype4, date: Date.new(2020,7,2))
al12 = ActivityLog.create(user: diligient_user, activity_type: actype5, date: Date.new(2020,7,3))
al13 = ActivityLog.create(user: diligient_user, activity_type: actype1, date: Date.new(2020,7,4))
al14 = ActivityLog.create(user: diligient_user, activity_type: actype2, date: Date.new(2020,7,5))
al15 = ActivityLog.create(user: diligient_user, activity_type: actype2, date: Date.new(2020,7,6))
al16 = ActivityLog.create(user: diligient_user, activity_type: actype7, date: Date.new(2020,7,7))
al17 = ActivityLog.create(user: diligient_user, activity_type: actype7, date: Date.new(2020,7,8))
al18 = ActivityLog.create(user: diligient_user, activity_type: actype4, date: Date.new(2020,7,9))
al19 = ActivityLog.create(user: diligient_user, activity_type: actype4, date: Date.new(2020,7,10))
al20 = ActivityLog.create(user: diligient_user, activity_type: actype1, date: Date.new(2020,7,10))

al21 = ActivityLog.create(user: forgetful_user, activity_type: actype1, date: Date.new(2020,6,25))
al22 = ActivityLog.create(user: forgetful_user, activity_type: actype4, date: Date.new(2020,6,28))
al23 = ActivityLog.create(user: forgetful_user, activity_type: actype6, date: Date.new(2020,7,1))
al24 = ActivityLog.create(user: forgetful_user, activity_type: actype6, date: Date.new(2020,7,4))
al25 = ActivityLog.create(user: forgetful_user, activity_type: actype7, date: Date.new(2020,7,9))
al26 = ActivityLog.create(user: forgetful_user, activity_type: actype7, date: Date.new(2020,7,10))




# ------ OLD SEEDS ------------------



# #user1 = User.create(name: "Stephanie")
# user2 = User.create(name: "Maurice")
# user3 = User.create(name: "Jane")
# user4 = User.create(name: "Rebecca") # has no logs


# actype1 = ActivityType.create(name: "Indoor - under 15 people", risk_score: 3)
# actype2 = ActivityType.create(name: "Indoor - over 15 people", risk_score: 6)
# actype3 = ActivityType.create(name: "Outdoor - under 15 people", risk_score: 1)
# actype4 = ActivityType.create(name: "Outdoor - over 15 people", risk_score: 2)
# actype5 = ActivityType.create(name: "Public transportation - under 15 min", risk_score: 6)
# actype6 = ActivityType.create(name: "Public transportation - over 15min", risk_score: 8)
# actype7 = ActivityType.create(name: "Self quarantine, no activities", risk_score: 0)



# aclog1 = ActivityLog.create(user: user1, activity_type: actype1, date: Date.new(2020,7,5))
# aclog2 = ActivityLog.create(user: user2, activity_type: actype3, date: Date.new(2020,7,8))
# aclog3 = ActivityLog.create(user: user3, activity_type: actype1, date: Date.new(2020,7,8))
# aclog4 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.new(2020,7,6))
# aclog5 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.new(2020,7,7))
# aclog6 = ActivityLog.create(user: user1, activity_type: actype2, date: Date.new(2020,7,8))
# #user1 should have a total score of 21, an average score of 1.something



