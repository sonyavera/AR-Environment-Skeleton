
class CommandLineInterface
    attr_accessor :user, :username
    def initialize(user = nil)
        @user = user
        log_in
    end

    def log_in
        new_user_prompt
        input = gets.chomp
        valid_yes_or_no_input(input)
        if input == "Y"
           start
        elsif input == "N"
            loop do
                enter_user_name_prompt
                user_name = gets.chomp
                if User.find_by(name: user_name)
                    self.user = User.find_by(name: user_name)
                    menu
                    break
                else    
                    puts "\nNo such username."
                end
            end
        end
    end

    def new_user_prompt
        puts "\nAre you a new user? [Y/N]"
    end

    def enter_user_name_prompt
        puts "\nEnter username:"
    end
    
    def start
        prompt_welcome
        loop do
            @username = gets.chomp
            if !already_username(@username) 
                break
            else
                puts "Already a username."
                puts "Please try another name."
            end
        end
        create_profile(@username)
        menu
    end

    def prompt_welcome
        puts "\nWelcome to the Covid Risk Tracker app!".cyan.bold
        puts "\nThis app helps you keep track of your COVID-19 exposure levels and get recommendations for safe activities based on your exposure risk level."
        puts "\nTo create your profile, please enter a username:"
    end

    def already_username(name)
        !!User.find_by(name: name)
    end

    def create_profile(name)
        self.user = User.create(name: name)
    end

    def menu
        loop do 
            menu_prompt
            input1 = gets.chomp.to_i
            if !valid_start_option_input(input1)
                invalid
            else
                case input1
                    when 1
                        log_activity
                    when 2 
                        update_delete 
                    when 3 
                        user.report_risk_level
                    when 4 
                        user.give_recs
                    when 5 
                        user.show_trend 
                end 
                break if input1 == 6 #changed to 6
            end
        end
    end

    def menu_prompt
        puts "\nWhat would you like to do?
            1. Log a new activity.
            2. Update or delete most recent activity. 
            3. Find out your COVID risk level by color: green, yellow or red.
            4. Get a recommendation for which activities are safe for you to do according to your current risk score.
            5. See your risk level for each consecutively logged day up to 14 days.
            6. Quit"
    end

    def valid_start_option_input(input)
        if input == 1 || input == 2 || input == 3 || input == 4 || input == 5 || input == 6 #change last input to 6
            return true
        else
            return false
        end
    end

    def invalid
        puts "\nPlease enter a valid input."
    end

    def log_activity
        loop do
            activity_options_prompt
            input1 = gets.chomp.to_i
            while !valid_activity_input(input1) do 
                invalid
                input1 = gets.chomp.to_i
            end
            store_activity(input1)
            more_logs_prompt
            input2 = gets.chomp
            while !valid_yes_or_no_input(input2) do 
                invalid
                input2 = gets.chomp
            end
            break if input2 == "N"
        end
    end

    def activity_options_prompt
        puts "\nWhat type of activity would you like to log?
            1. Indoor - under 15 people
            2. Indoor - over 50 people
            3. Outdoor - under 15 people
            4. Outdoor - over 15 people
            5. Public transportation - under 15 min
            6. Public transportation - over 15min
            7. Self quarantine, no activities"
    end

    def valid_activity_input(num)
        if num > 0 && num < 8
            return true
        else
            return false
        end
    end

    def valid_yes_or_no_input(string)
        if string == "Y" || string == "N"
            return true
        else
            return false
        end
    end

    def store_activity(number)
        activity_type_input = ActivityType.all[number-1]
        ActivityLog.create(user: self.user, activity_type: activity_type_input, date: Date.today)
    end

    def more_logs_prompt
        puts "\nOk! We’ve logged that activity for you. Would you like to log another activity? Respond with Y/N"
    end

    def update_delete
        if user.logged_today?
            last_log = user.my_logs.last
            show_log(last_log)
            update_delete_log_prompt
            input = gets.chomp
            while !valid_update_or_delete_input(input) do 
                invalid
                input = gets.chomp 
            end
            if input == "U"
                update_log 
            elsif input == "D"
                user_name = user.name
                user.delete_most_recent_log
                #reassign_user(user_name)
            end
        else
            puts "\nYou have not made any logs today, so you are not able to make an update or delete a log.\n"
        end
    end

    def show_log(log)
        puts "Here's your last log:"
        puts "user: #{log.user.name}\nactivitiy: #{log.user.report_last_activity_type}\ndate: #{log.date}"
    end

    def update_delete_log_prompt
        puts "\nPress 'U' to update or 'D' to delete."
    end

    def valid_update_or_delete_input(string)
        if string == "D" || string == "U"
            return true
        else
            return false
        end
    end

    def update_log
        update_prompt
        input = gets.chomp.to_i
        while !valid_activity_input(input)
            invalid
            input = gets.chomp.to_i
        end
        #user.update_most_recent_log(ActivityType.create(name: input))
        activity_type_input = ActivityType.all[input-1]
        user.activity_logs.last.update(activity_type: activity_type_input)
        #ActivityLog.create(user: self.user, activity_type: activity_type_input, date: Date.today)
    end

    def reassign_user(name)
        @user = User.all.last
        #temp User.find_by(:name = name)
        #temp = ActivityLog.all.find{|log_instance| log_instance.user.name == name}.user
        #self.user = temp
    end

    def update_prompt
        puts "\nWrite the number that corresponds to the activity you'd like to change your log to:\n"
        puts "1. Indoor - under 15 people\n2. Indoor - over 50 people\n3. Outdoor - under 15 people\n4. Outdoor - over 15 people\n5. Public transportation - under 15 min\n6. Public transportation - over 15min\n7. Self Quarantine, no activities"
    end
end