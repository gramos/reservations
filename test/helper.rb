ENV['ENV'] = 'test'

require_relative "../app"
Dir["./db/seeds/*.rb"].each { |rb| require rb }

DB.disconnect if defined? DB

puts "[ USING ] #{DB_NAME} Database"

