class Reservation < Sequel::Model

  many_to_one :service
  many_to_one :customer
  many_to_one :address
  many_to_one :reservation_type

  def full_address
    a = address
    "#{a.street} #{a.number} #{a.tower} #{a.floor} #{a.apartment}"
  end

  def self.make(params)

    customer = Customer.new params['customer']
    customer.save

    address = Address.new params['address']
    address.customer_id = customer.id
    address.save

    reservation = Reservation.new params['reservation']
    reservation.customer_id = customer.id
    reservation.service_id  = params['service_id']
    reservation.address_id  = address.id
    reservation.save

    reservation
  end
end
