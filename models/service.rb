class Service < Sequel::Model
  many_to_one :driver
  many_to_one :scheduled_time
end
