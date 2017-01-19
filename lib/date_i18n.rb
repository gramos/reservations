class DateI18n

  DAYS = {0 => "Domingo",
          1 => "Lunes",
          2 => "Martes",
          3 => "Miercoles",
          4 => "Jueves",
          5 => "Viernes",
          6 => "Sabado"}

  MONTHS = {1 => "Enero",
          2 => "Febrero",
          3 => "Marzo",
          4 => "Abril",
          5 => "Mayo",
          6 => "Junio",
          7 => "Julio",
          8 => "Agosto",
          9 => "Septiembre",
          10 => "Octubre",
          11 => "Noviembre",
          12 => "Diciembre"}

  def initialize(date)
    if date.kind_of? String
      @date = Date.parse date
    else
      @date = date
    end
  end

  def to_s
    "#{ DateI18n::DAYS[ @date.wday] } #{ @date.day } de " \
    "#{ DateI18n::MONTHS[ @date.month]}"
  end
end
