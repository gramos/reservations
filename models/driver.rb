class Driver < Sequel::Model

  def full_name
    "#{last_name} #{first_name}"
  end
end

