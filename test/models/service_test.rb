require_relative '../helper'

prepare do
  DBSeed::Base.delete_all!
  DBSeed::Base.run_all!
end

setup do
  @service = Service.first

  reservation_type = DB[:reservation_types].where(:name => 'Comun').first
  
  @reservation_params = {'address' => {:street => 'Pje Lassaga',
                                      :number => '4732',
                                      :phone_number => '1223444'},

                         'customer' => {:first_name => 'Bruce',
                                       :last_name => 'Lee'},

                         'reservation' => {type_id: reservation_type[:id]},

                         'service_id' => @service.id}
end


test '#available_reservation_types' do
  assert @service.available_reservation_types == DB[:reservation_types].all

  @reservation_params['reservation']['quantity'] = '4'
  reservation = Reservation.make @reservation_params 

  assert @service.available_reservation_types.
    map{|rt| rt[:name]}.sort == ['Sobre', 'Paquete'].sort
end

