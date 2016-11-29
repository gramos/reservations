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

    within "#servicio_#{@service.id}" do
      page.has_content?('( 4 )')
    end

    click_link "button-create-reservation-#{@service.id}"
    fill_in 'reservation[customer][last_name]', with: 'Lee'
    fill_in 'reservation[customer][first_name]', with: 'Bruce'

    fill_in 'reservation[address][street]', with: 'Hollywood Boulevard'
    fill_in 'reservation[address][number]', with: '1234'
    select 'Comun', from: 'reservation[reservation][type_id]'
    click_button 'Crear Reserva'

    within "#servicio_#{@service.id}" do
      page.has_content?('( 3 )')
    end
  end
end
