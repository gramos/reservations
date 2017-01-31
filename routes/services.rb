class Services < Cuba
  define do
    on get do
      on param('date') do |d|
        date = Date.parse d
        services = Service.where(:date => date)

        render 'services/index', { :services => services }
      end

      services = Service.where(:date => Date.today)
      render 'services/index', { :services => services }
    end

    on post, ':id/reservations/' do |service_id|
      on param(:reservation) do |params|
        params['service_id'] = service_id
        Reservation.make params

        date = Service[service_id].date.strftime('%a %b %d %Y')
        res.redirect "/?date=#{URI.escape( date )}"
      end
    end

    on post, param('create_service_date') do |d|
      date = Date.parse d
      DBSeed::Services.run!(date)
      res.redirect "/#{req.params['from']}?date=#{URI.escape(d)}"
    end

    on post, 'bulk', param('services') do |params|
      service = nil
      params.each do |k, v|
        id = k.to_i
        service = Service[id]
        service.programmed = v['programmed'].nil? ? false : true
        service.update(v)
      end

      date = service.date.strftime('%a %b %d %Y')
      res.redirect "/services?date=#{URI.escape( date )}"
    end

    on post, param('service'),
       param('scheduled_time')  do |service_params, sch_time_params|

      scheduled_time = ScheduledTime.create sch_time_params.merge!(:custom => true)

      service_params.merge!(:scheduled_time_id => scheduled_time.id)
      service = Service.create service_params

      date = service.date.strftime('%a %b %d %Y')
      res.redirect "/services?date=#{URI.escape( date )}"
    end

  end
end
