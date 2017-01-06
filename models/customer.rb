class Customer < Sequel::Model
  one_to_many :addresses
  one_to_many :reservations

  def full_name
    "#{first_name} #{last_name}"
  end
end
