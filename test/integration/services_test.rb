require_relative "integration_helper"

scope 'Daily Services' do
  setup do
    @service = Service.where(:date => Date.today).first
  end

  test 'Service page should list days services' do
    visit '/services'
    assert has_content? @service.driver.full_name
  end

  test 'can edit and change driver for a particular service' do
    visit '/services'
    select('Nestor Farina', from: "driver_service_#{@service.id}")
    click_button("save_service_#{@service.id}")

    visit '/'
    within("tr#servicio_#{@service.id}") do
      assert has_content? 'Nestor Farinas'
    end
  end
end
