class Customer < Sequel::Model

  many_to_one :address
end
