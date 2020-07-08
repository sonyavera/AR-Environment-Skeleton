class CommandLineInterface
    attr_accessor :user
    def initialize(user = nil)
        binding.pry
        @user = user
        start
    end

    def start
        prompt_welcome
        create_profile(name = gets.chomp)
        menu
    end

    def prompt_welcome
        puts "Welcome to the Covid Risk Tracker app"
        puts "This app helps you keep track of your covid exposure levels and see helpful tips and statistics"
        puts "To create your profile, please enter your name"
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
                    #when 2 #update/delete 
                    #when 3 #get score 
                    #when 4 #get recommendation
                    #when 5 #see trend 
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
        if input == 1 || input == 9
            return true
        else
            return false
        end
    end

    def invalid
        puts "Please enter valid input"
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
            6. Public transportation - over 15min"
    end

    def valid_activity_input(num)
        if num > 0 && num < 7
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
        ActivityLog.create(user: self.user, activity_type: ActivityType.create(name: number), date: Time.now)
        binding.pry
    end

    def more_logs_prompt
        puts "Ok! We’ve logged that activity for you. Would you like to log another activity? Respond with Y/N"
    end

    def update_delete
        #last_log = ActivityLog.last
        #show_log(last_log)
        #update_log_prompt
        #input = gets.chomp
        #loop while !valid_input do invalid end
        #if input == "U" do update_log(last_log)
        #elsif input == "D" do delete_log(last_log)
    end

    def show_log(log)
        puts "#{log.user.name}"
        puts "#{log.activity_type.name}"
        puts "#{log.date}"
    end
end