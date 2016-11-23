class Service < Sequel::Model
  many_to_one :driver
  many_to_one :scheduled_time
  one_to_many :reservations

  def available_seats
    type = DB[:reservation_types].where(:name => 'Comun').first

    reserved_seats = reservations.select{|r| r[:type_id] == type[:id] }.
                     reduce(0){ |sum, r| sum = sum + r.quantity }

    driver.car_seats - reserved_seats
  end
end
