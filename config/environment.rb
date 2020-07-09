require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "db/development.sqlite3"
)


#ActiveRecord::Base.logger = Logger.new(STDOUT)

#Uncomment above ^ and comment below \/ for debugging

ActiveRecord::Base.logger = nil

require_all 'app/models'

