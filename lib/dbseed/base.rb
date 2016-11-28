module DBSeed
  
  class Base
    def self.run_all!
      DBSeed::ReservationTypes.run!
      DBSeed::Drivers.run!
      DBSeed::ScheduledTimes.run!
      DBSeed::Services.run!
      DBSeed::Cities.run!
    end  
  end

end
