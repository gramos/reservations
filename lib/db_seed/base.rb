module DBSeed
  
  class Base
    def self.run_all!
      DBSeed::ReservationTypes.run!
      DBSeed::Drivers.run!
      DBSeed::ScheduledTimes.run!
      DBSeed::Services.run!
      DBSeed::Cities.run!
    end

    def self.delete_all!
      [:reservations, :services, :reservation_types,
       :scheduled_times, :addresses, :customers, :cities,
       :drivers].each do |x|
        Sequel::Model.db.from(x).delete
      end
    end
  end

end
