class Customer < Sequel::Model

  many_to_one :address

  def full_name
    "#{first_name} #{last_name}"
  end

end
