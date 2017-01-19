class ScheduledTime < Sequel::Model
  many_to_one :city

  def day_name
    DateI18n::DAYS[day]
  end

end
