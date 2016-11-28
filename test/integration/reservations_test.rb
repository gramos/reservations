require_relative "integration_helper"


scope 'Daily Services' do

  test 'Reservation page should list days services' do
    visit '/'
    service = Service.where(:date => Date.today).first
    assert has_content? service.driver.full_name
  end

end

