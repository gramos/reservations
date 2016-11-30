class Service < Sequel::Model
  many_to_one :driver
  many_to_one :scheduled_time
  one_to_many :reservations

  def available_seats
    reserved_seats = reservations_like('Comun').
                     reduce(0){ |sum, r| sum = sum + r.quantity }

    driver.car_seats - reserved_seats
  end

  def reservations_like(type)
    type = DB[:reservation_types].where(:name => type).first
    reservations(true).select{|r| r[:type_id] == type[:id] }
  end

  def available_reservation_types
    if  available_seats == 0
      DB[:reservation_types].all.select{|rt| rt[:name] =~ /Paquete|Sobre/}
    else
      DB[:reservation_types].all
    end
  end
end
