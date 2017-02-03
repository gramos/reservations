class Reservations < Cuba
  define do
    on root do
      on get, param('date') do |d|
        date = Date.parse d
        services = Service.where(:date => date)

        render 'reservations', { :services => services }
      end

      services = Service.where(:date => Date.today)
      render 'reservations', { :services => services }
    end

  end
end
