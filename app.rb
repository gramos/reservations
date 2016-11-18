require 'cuba'
require 'mote'
require 'cuba/safe'
require 'mote/render'
require 'cuba/sugar/as'

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin Mote::Render
Cuba.plugin Cuba::Sugar::As

Dir["./lib/**/*.rb"].each { |rb| require rb }
Dir["./models/**/*.rb"].each { |rb| require rb }
Dir["./routes/**/*.rb"].each { |rb| require rb }
Dir["./filters/**/*.rb"].each { |rb| require rb }
Dir["./helpers/**/*.rb"].each { |rb| require rb }

Cuba.use Rack::Static,
         urls: %w[/js /css /img],
         root: File.expand_path("./public", __dir__)

# ----------------------------------------------------------------
# Main app.
#
Cuba.define do
  on root do
    render 'reservations'
  end  
end
