class CommandLineInterface
    attr_accessor :user
    def initialize(user = nil)
        #binding.pry
        @user = user
        start
    end

    def start
        prompt_welcome
        create_profile(name = gets.chomp)
        menu
    end

    def prompt_welcome
        puts "Welcome to the Covid Risk Tracker app."
        puts "This app helps you keep track of your COVID-19 exposure levels and get recommendations for safe activities based on your exposure risk level."
        puts "To create your profile, please enter your name."
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
                break if input1 == 9
            end
        end
    end

    def menu_prompt
        puts "What would you like to do?
            1. Log a new activity.
            2. Update or delete an activity. 
            3. Find out your cumulative COVID risk score.
            4. Get a recommendation for which activities are safe for you to do according to your current risk score.
            5. See a visual representation of your risk trend over the past 2 weeks.
            9. quit"
    end

    def valid_start_option_input(input)
        if input == 1 || input == 2 || input == 3 || input == 4 || input == 5 || input == 9
            return true
        else
            return false
        end
    end

    def invalid
        puts "Please enter valid input."
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
        puts "What type of activity would you like to log?
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
        activity_type_input = ActivityType.all[number]
        ActivityLog.create(user: self.user, activity_type: activity_type_input, date: Date.today)
        #binding.pry
    end

    def more_logs_prompt
        puts "Ok! We’ve logged that activity for you. Would you like to log another activity? Respond with Y/N"
    end

    def update_delete
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
            reassign_user(user_name)
        end
    end

    def show_log(log)
        puts "Here's your last log:"
        puts "user: #{log.user.name}\nactivitiy: #{log.user.report_last_activity_type}\ndate: #{log.date}"
        #binding.pry
    end

    def update_delete_log_prompt
        puts "Press 'U' to update or 'D' to delete."
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
        user.update_most_recent_log(ActivityType.create(name: input))
        #binding.pry
    end

    def reassign_user(name)
        temp = ActivityLog.all.find{|log_instance| log_instance.user.name == name}.user
        self.user = temp
    end

    def update_prompt
        puts "Write the number that corresponds to the activity you'd like to change your log to:"
        puts "1. Indoor - under 15 people
            2. Indoor - over 50 people
            3. Outdoor - under 15 people
            4. Outdoor - over 15 people
            5. Public transportation - under 15 min
            6. Public transportation - over 15min
            7. Self Quarantine, no activities"
    end
end