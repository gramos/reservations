require 'cuba'
require 'mote'
require 'cuba/safe'
require 'mote/render'
require 'cuba/sugar/as'
require 'sequel'
require 'logger'
require 'date'
require 'paginator'

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

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

# ----------------------------------------------------------------
# Post endpoints.
#
  on post, 'services/:id/reservations/' do |service_id|
    on param(:reservation) do |params|
      params['service_id'] = service_id
      Reservation.make params

      date = Service[service_id].date.strftime('%a %b %d %Y')
      res.redirect "/?date=#{URI.escape( date )}"
    end
  end

  on post, 'services', param('create_service_date') do |d|
    date = Date.parse d
    DBSeed::Services.run!(date)
    res.redirect "/#{req.params['from']}?date=#{URI.escape(d)}"
  end

  on post, 'reservations/:id' do |id|
    reservation = Reservation[id]

    date = reservation.service.date.strftime('%a %b %d %Y')
    reservation.update(:canceled => true)
    res.redirect "/?date=#{URI.escape( date )}"
  end

  on post, 'services/bulk', param('services') do |params|
    service = nil
    params.each do |k, v|
      id = k.to_i
      service = Service[id]
      service.programmed = v['programmed'].nil? ? false : true
      service.update(v)
    end

    date = service.date.strftime('%a %b %d %Y')
    res.redirect "/services?date=#{URI.escape( date )}"
  end

  # -----------------------------------------------------
  # Delete customer
  #
  on post, 'customers/:id/delete' do |id|
    DB.transaction do
      Address.where("customer_id = ?", id).delete
      Customer[id].delete
    end

    res.redirect "/customers"
  end

  # -----------------------------------------------------
  # Update customer / create or update address
  #
  on post, 'customers/:id' do |id|
    address_id = req.params['address'].delete('id')
    customer   = Customer[id]

    DB.transaction do
      customer.update( req.params['customer'] )
      if address_id.empty?
        customer.add_address( req.params['address'] )
      else
        Address[address_id].update( req.params['address'] )
      end
    end

    res.redirect "/customers"
  end

  # ----------------------------------------------------------
  # Create customer
  #
  on post, 'customers', param('customer'), param('address') do |c, a|
    a.delete('id')

    DB.transaction do
      customer = Customer.create(c)
      customer.add_address(a)
    end

    res.redirect "/customers"
  end

# ----------------------------------------------------------------
# Get endpoints.
#
  on get, ':city/customers', param('q') do |city, q|
    as_json do

      city_id = DB[:cities].where( :name => URI.decode(city) ).first[:id]

      Customer.where(:last_name => /#{q}/i).all.map do |c|

        address = Address.where(:customer_id => c.id, :city_id => city_id).first
        address ||= {}

        addresses   = Address.where( :customer_id => c.id,
                                     :city_id => city_id ).map{|a| a.to_hash}
        addresses ||= []

        c.to_hash.merge({:address => address.to_hash, :addresses => addresses})
      end
    end
  end

  on get, 'customers', param('q') do |q|
    customers_ds = Customer.order(:first_name).
                   where( Sequel.function(:lower, :last_name).
                          like("#{q.downcase}%") )

    @pager = Paginator.create(customers_ds.count, 8) do |offset, per_page|
      customers_ds.limit(per_page).offset(offset)
    end

    @page = @pager.page( req.params['page'] )

    render 'customers/index', { :customers => @page,
                                :customer => Customer.new }

  end

  on get, 'customers' do
    @pager = Paginator.create(Customer.count, 8) do |offset, per_page|
      Customer.order(:last_name).limit(per_page).offset(offset)
    end

    @page = @pager.page( req.params['page'] )

    on param('customer_id') do |id|
      render 'customers/index', { :customers => @page,
                                  :customer => Customer[id] }
    end

    render 'customers/index', { :customers => @page,
                                :customer => Customer.new }
  end

  on get, 'services' do
    on param('date') do |d|
      date = Date.parse d
      services = Service.where(:date => date)

      render 'services/index', { :services => services }
    end

    services = Service.where(:date => Date.today)
    render 'services/index', { :services => services }
  end

  on root do
    on param('date') do |d|
      date = Date.parse d
      services = Service.where(:date => date)

      render 'reservations', { :services => services }
    end

    services = Service.where(:date => Date.today)
    render 'reservations', { :services => services }
  end
end
