class Driver < Sequel::Model

  def full_name
    "#{last_name} #{first_name}"
  end

  def self.ordered_all
    drivers = Driver.order_by(:last_name).all
    no_asig = drivers.select{|d| d.first_name == 'ASIGNADO'}.first
    drivers.delete_if{|d| d.first_name == 'ASIGNADO'}
    drivers.unshift(no_asig)
    drivers
  end
end

