require 'cuba'
require 'mote'
require 'cuba/safe'
require 'mote/render'
require 'cuba/sugar/as'
require 'sequel'
require 'logger'
require 'date'

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin Mote::Render
Cuba.plugin Cuba::Sugar::As

Dir["./lib/**/*.rb"].each { |rb| require rb }
Dir["./routes/**/*.rb"].each { |rb| require rb }
Dir["./filters/**/*.rb"].each { |rb| require rb }
Dir["./helpers/**/*.rb"].each { |rb| require rb }

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

  on post, 'services/:id/reservations/' do |service_id|

    on param(:reservation) do |params|
      params['service_id'] = service_id
      Reservation.make params
      res.redirect '/'
    end
  end

  on root do
    services = Service.where(:date => Date.today)
    render 'reservations', { :services => services }
  end
end
