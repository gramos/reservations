module DBSeed
  class ScheduledTimes
    def self.run!
      st_rosario_lunes_a_viernes = [
        {:time => '05:30'},
        {:time => '06:30'},
        {:time => '08:00'},
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
        {:time => '20:00'}
      ]

      [1, 2, 3, 4, 5].each do |d|
        st_rosario_lunes_a_viernes.each do |t|
          city = DB[:cities].where(:name => /rosario/i).first
          data = t.merge( :day => d, :city_id => city[:id] )
          DB[:scheduled_times].insert data
        end
      end

      st_san_nicolas_lunes_a_viernes = [
        {:time => '06:00'},
        {:time => '07:00'},
        {:time => '08:00'},
        {:time => '09:00'},
        {:time => '10:00'},
        {:time => '12:00'},
        {:time => '13:00'},
        {:time => '14:00'},
        {:time => '15:00'},
        {:time => '16:00'},
        {:time => '17:00'},
        {:time => '18:00'},
        {:time => '19:00'},
        {:time => '20:00'}
      ]

      [1, 2, 3, 4, 5].each do |d|
        st_san_nicolas_lunes_a_viernes.each do |t|
          city = DB[:cities].where(:name => /san nicolas/i).first
          data = t.merge( :day => d, :city_id => city[:id] )
          DB[:scheduled_times].insert data
        end
      end

       st_rosario_sabado = [
        {:time => '06:00'},
        {:time => '08:00'},
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
        {:time => '20:00'}
      ]

       st_rosario_sabado.each do |t|
         city = DB[:cities].where(:name => /rosario/i).first
         data = t.merge( :day => 6, :city_id => city[:id] )
         DB[:scheduled_times].insert data
       end

       st_san_nicolas_sabado = [
         {:time => '06:00'},
         {:time => '08:00'},
         {:time => '10:00'},
         {:time => '12:00'},
         {:time => '13:00'},
         {:time => '14:00'},
         {:time => '15:00'},
         {:time => '16:00'},
         {:time => '17:00'},
         {:time => '18:00'},
         {:time => '19:00'},
         {:time => '20:00'}
      ]

       st_san_nicolas_sabado.each do |t|
          city = DB[:cities].where(:name => /san nicolas/i).first
          data = t.merge( :day => 6, :city_id => city[:id] )
          DB[:scheduled_times].insert data
        end

       st_rosario_domingo = [
         {:time => '06:30'},
         {:time => '08:00'},
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
         {:time => '20:00'}
      ]

       st_rosario_domingo.each do |t|
          city = DB[:cities].where(:name => /rosario/i).first
          data = t.merge( :day => 0, :city_id => city[:id] )
          DB[:scheduled_times].insert data
       end

        st_san_nicolas_domingo = [
         {:time => '08:00'},
         {:time => '10:00'},
         {:time => '12:00'},
         {:time => '13:00'},
         {:time => '14:00'},
         {:time => '15:00'},
         {:time => '16:00'},
         {:time => '17:00'},
         {:time => '18:00'},
         {:time => '18:00'},
         {:time => '19:00'},
         {:time => '20:00'},
         {:time => '22:00'}
      ]

       st_san_nicolas_domingo.each do |t|
          city = DB[:cities].where(:name => /san nicolas/i).first
          data = t.merge( :day => 0, :city_id => city[:id] )
          DB[:scheduled_times].insert data
        end
    end
  end
end
