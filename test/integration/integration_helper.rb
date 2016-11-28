require "cuba/capybara"
require_relative "../../app"

Dir["./db/seeds/*.rb"].each { |rb| require rb }

prepare do
  DBSeed::Base.run_all!
end
