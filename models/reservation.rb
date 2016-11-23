class Reservation < Sequel::Model

  many_to_one :service
  many_to_one :customer
  many_to_one :address
  many_to_one :reservation_type
end
