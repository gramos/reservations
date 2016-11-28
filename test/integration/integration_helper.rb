require "cuba/capybara"

ENV['ENV'] = 'test'

require_relative "../../app"

Dir["./db/seeds/*.rb"].each { |rb| require rb }

prepare do
  DBSeed::Base.delete_all!
  DBSeed::Base.run_all!
end
