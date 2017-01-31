require "cuba/capybara"
require "capybara-webkit"
require_relative '../helper'

Capybara::Webkit.configure do |config|
  config.allow_url("fonts.googleapis.com")
  config.allow_url("yui.yahooapis.com")
end

prepare do
  DBSeed::Base.delete_all!
  DBSeed::Base.run_all!
end

def test_js(str = nil, &block)
  Capybara.current_driver = :webkit
  test str, &block
  Capybara.use_default_driver
end

def login!(username = "lacasa", password = "12345678")
  visit '/login'
  fill_in 'login[username]', with: username
  fill_in 'login[password]',  with: password
  click_button 'Ingresar'
end
