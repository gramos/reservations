module DBSeed

  class Services
    def self.run!(date = Date.today)
      stimes = DB[:scheduled_times].where('day = ? AND custom = false', date.wday)

      stimes.each do |st|
        DB[:services] << { :date => date,
                           :driver_id => DB[:drivers].first[:id],
                           :scheduled_time_id => st[:id] }
      end
     end
  end
end
