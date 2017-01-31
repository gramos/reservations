require 'cuba'
require 'mote'
require 'cuba/safe'
require 'mote/render'
require 'cuba/sugar/as'
require 'sequel'
require 'shield'
require 'logger'
require 'date'
require 'paginator'

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"
Cuba.use Shield::Middleware

Cuba.plugin Shield::Helpers
Cuba.plugin Cuba::Safe
Cuba.plugin Mote::Render
Cuba.plugin Cuba::Sugar::As

Sequel::Model.plugin :timestamps

Dir["./lib/**/*.rb"].each { |rb| require rb }
Dir["./routes/**/*.rb"].each { |rb| require rb }
Dir["./filters/**/*.rb"].each { |rb| require rb }
Dir["./helpers/**/*.rb"].each { |rb| require rb }
Dir["./db/seeds/*.rb"].each { |rb| require rb }

Cuba.use Rack::Static,
         urls: %w[/js /css /img],
         root: File.expand_path("./public", __dir__)

# ----------------------------------------------------------------
# Load settings and config var in ENV.
#
module Settings
  File.read("env.sh").scan(/(.*?)="?(.*)"?$/).each do |key, value|
    ENV[key] ||= value
  end
end


# ----------------------------------------------------------------
# Set database name based on env
#
if ENV['ENV'] == 'test'
  DB_NAME = ENV['DB_TEST_NAME']
else
  DB_NAME = ENV['DB_NAME']
end

# ----------------------------------------------------------------
# Sequel init.
#
DB = Sequel.postgres(DB_NAME, :user => ENV['DB_USER'],
                     :password => ENV['DB_PASSWORD'],
                     :host => ENV['DB_HOST'],
                     :port => ENV['DB_PORT'])

Dir["./models/**/*.rb"].each { |rb| require rb }

# ----------------------------------------------------------------
# Main app.
#
Cuba.define do
  on 'services'do
    if authenticated(User)
      run Services
    else
      res.redirect '/login'
    end
  end

  on 'customers' do
    if authenticated(User)
      run Customers
    else
      res.redirect '/login'
    end
  end

  on get, 'logout' do
    logout(User)
    res.redirect '/login'
  end

  on 'users' do
    on get, 'change_password' do
      if authenticated(User)
        render 'users/change_password'
      else
        res.redirect '/login'
      end
    end

    on post, 'change_password', param('user') do |p|
      if u = authenticated(User)
        if Shield::Password.check(p['current_password'], u.crypted_password)
          u.password              = p['new_password']
          # u.password_confirmation = p['password_confirmation']
          u.save
          res.redirect '/logout'
        end
      else
        res.redirect '/login'
      end
    end
  end

  on 'login' do
    on get do
      render 'login'
    end

    on post, param('login') do |params|
      if login User, params['username'], params['password']
        remember if req[:remember_me]
        res.redirect(req[:return] || '/')
      else
        render 'login'
        res.status = 302
      end
    end

    on default do
      render 'login'
    end
  end

  on root do
    if authenticated(User)
      run Reservations
    else
      res.redirect '/login'
    end
  end
end
