module DBSeed
  class ScheduledTimes
    def self.run!
      st = [
        {:time => '06:00'},
        {:time => '07:00'},
        {:time => '08:00'},
        {:time => '09:00'},
        {:time => '10:00'},
        {:time => '11:00'},
        {:time => '12:00'},
        {:time => '13:00'},
        {:time => '14:00'},
        {:time => '15:00'},
        {:time => '16:00'},
        {:time => '17:00'},
        {:time => '18:00'},
        {:time => '19:00'},
        {:time => '20:00'},
        {:time => '21:00'},
        {:time => '22:00'}
      ]

      [1, 2, 3, 4, 5, 6, 7].each do |d|
        st.each do |t|
          city = DB[:cities].where(:name => /rosario/i).first
          data = t.merge( :day => d, :city_id => city[:id] )
          DB[:scheduled_times].insert data

          city = DB[:cities].where(:name => /san nicolas/i).first
          data = t.merge( :day => d, :city_id => city[:id] )
          DB[:scheduled_times].insert data
        end

      end
    end
  end
end
