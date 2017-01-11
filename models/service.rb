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

Service.dataset_module do
  def by_city(city_name)
    city_id = DB[:cities].where(:name => /#{city_name}/i ).first[:id]
    s_times_ids = DB[:scheduled_times].
                  where(:city_id => city_id).select_map(:id)

    where(:scheduled_time_id => s_times_ids)
  end

  def ordered_by_time(date = Date.today)
    ids = DB.fetch("SELECT s.id
               FROM services AS s, scheduled_times AS st
               WHERE s.date = '#{ date }' AND
               st.id = s.scheduled_time_id
               ORDER BY st.time" ).map{|e| e[:id]}

    Service.where(:id => ids)
  end
end
