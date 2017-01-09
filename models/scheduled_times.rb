class ScheduledTime < Sequel::Model
  many_to_one :city

  DAYS = {0 => "Domingo",
          1 => "Lunes",
          2 => "Martes",
          3 => "Miercoles",
          4 => "Jueves",
          5 => "Viernes",
          6 => "Sabado"}

  def day_name
    DAYS[day]
  end

end
