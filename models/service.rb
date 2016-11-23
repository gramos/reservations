class Service < Sequel::Model
  many_to_one :driver
  many_to_one :scheduled_time
  one_to_many :reservations
  
  def available_seats
    type = DB[:reservation_types].where(:name => 'Comun').first

    human_reservations = reservations.select do |r|
                           r[:type_id] == type[:id]
                         end 

    reserved_seats = human_reservations.
                     reduce(0){ |sum, r| sum = sum + r.quantity }

    driver.car_seats - reserved_seats
  end
end
