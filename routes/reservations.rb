class Reservations < Cuba
  define do
    on root do
      on get, param('date') do |d|
        date = Date.parse d
        services = Service.where(:date => date, :programmed => true)

        render 'reservations', { :services => services }
      end

      services = Service.where(:date => Date.today, :programmed => true)
      render 'reservations', { :services => services }
    end

  end
end
