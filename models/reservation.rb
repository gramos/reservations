class Reservation < Sequel::Model

  many_to_one :service
  many_to_one :customer
  many_to_one :address
  many_to_one :reservation_type, :key => :type_id

  def full_address
    a = address
    "Calle: #{a.street} - Numero: #{a.number} " +
    "Torre: #{a.tower} - Piso: #{a.floor} - Dpto: #{a.apartment}"
  end

  def self.make(params)
    address = Address.new params['address']

    if params['customer_id'].nil? or params['customer_id'].empty?
      customer = Customer.new params['customer']
      customer.save
      address.customer_id = customer.id
    else
      customer = Customer[ params['customer_id'].to_i ]
    end

    address.save

    reservation = Reservation.new params['reservation']
    reservation.customer_id = customer.id
    reservation.service_id  = params['service_id']
    reservation.address_id  = address.id
    reservation.save

    reservation
  end

  def use_seat?
    ! ['Sobre', 'Paquete'].include? reservation_type.name
  end
end
