class Reservations < Cuba
  define do
    on post, 'reservations/:id' do |id|
      reservation = Reservation[id]

      date = reservation.service.date.strftime('%a %b %d %Y')
      reservation.update(:canceled => true)
      res.redirect "/?date=#{URI.escape( date )}"
    end

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
