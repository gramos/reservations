class ReservationType < Sequel::Model

  one_to_many :reservations
end
