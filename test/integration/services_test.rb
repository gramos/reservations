require_relative "integration_helper"

scope 'Services' do
  setup do
    @service = Service.where(:date => Date.today).first
  end

  test 'can edit and change driver for a particular service' do
    visit '/services'
    select('Marcelo Bissuti', from: "driver_service_#{@service.id}")
    click_button("save_service_#{@service.id}")

    visit '/'
    within("tr#servicio_#{@service.id}") do
      assert has_content? 'Marcelo Bissuti'
    end
  end

  test 'disabling a service' do
    visit '/services'

    within("tr#servicio_#{@service.id}") do
      uncheck "service[programmed]"
    end

    click_button("save_service_#{@service.id}")

    has_css? "tr#servicio_#{@service.id}.disabled"
  end
end
