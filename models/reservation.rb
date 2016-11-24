class Reservation < Sequel::Model

  many_to_one :service
  many_to_one :customer
  many_to_one :address
  many_to_one :reservation_type

  def full_address
    a = address
    "#{a.street} #{a.number} #{a.tower} #{a.floor} #{a.apartment}"
  end

end
