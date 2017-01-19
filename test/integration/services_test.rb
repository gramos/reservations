require_relative "integration_helper"

scope 'Services' do
  setup do
    @service = Service.where(:date => Date.today).first
  end

  test 'can edit and change driver for a particular service' do
    visit '/services'
    select('Bissuti Marcelo', from: "driver_service_#{@service.id}")
    click_button("save_service_rosario")

    visit '/'
    within("tr#servicio_#{@service.id}") do
      assert has_content? 'Bissuti Marcelo'
    end
  end

  test 'disabling a service' do
    visit '/services'

    within("tr#servicio_#{@service.id}") do
      uncheck "services[#{@service.id}][programmed]"
    end

    click_button("save_service_rosario")

    has_css? "tr#servicio_#{@service.id}.disabled"
  end
end
