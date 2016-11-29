require_relative "integration_helper"


scope 'Daily Services' do

  setup do
    @service = Service.where(:date => Date.today).first
  end

  test 'Reservation page should list days services' do
    visit '/'
    assert has_content? @service.driver.full_name
  end

  test_js 'Hago una reserva de un servicio' do
    visit '/'
    click_link "button-create-reservation-#{@service.id}"

    fill_in 'reservation[customer][last_name]', with: 'Lee'
    fill_in 'reservation[customer][first_name]', with: 'Bruce'

    fill_in 'reservation[address][street]', with: 'Hollywood Boulevard'
    fill_in 'reservation[address][number]', with: '1234'
    select 'Comun', from: 'reservation[reservation][type_id]'
  end
  
end
