require_relative '../helper'

prepare do
  DBSeed::Base.delete_all!
  DBSeed::Base.run_all!
end

setup do
  @drivers = Driver.ordered_all
end

test ".ordered_all we need the fake 'NO ASIGNADO' driver as the first one" do
  assert @drivers.first.first_name == 'ASIGNADO'
  assert @drivers[2].last_name > @drivers[1].last_name
  assert @drivers[3].last_name > @drivers[2].last_name
end
