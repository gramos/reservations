# coding: utf-8
module DBSeed

  class Drivers
    def self.run!
      DB[:drivers].insert(:first_name => 'Nestor',
                          :last_name  => 'Farina',
                          :dni        => '13958149',
                          :mobile     => '3416688834',
                          :car        => 'Volkswagen Suran 2013',
                          :car_color  => 'Gris Oscuro',
                          :car_license=> 'MKG-262', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Marcelo',
                          :last_name  => 'Bissuti',
                          :dni        => '10594450',
                          :mobile     => '3412011883',
                          :car        => 'Renault Fluence 2015',
                          :car_color  => 'Gris claro',
                          :car_license=> 'PCT-868', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Andres',
                          :last_name  => 'Ricci',
                          :dni        => '25101854',
                          :mobile     => '3416505478',
                          :car        => 'Ford Eco Sport 2014',
                          :car_color  => 'Negro',
                          :car_license=> 'MCN-982', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Ariel',
                          :last_name  => 'Aguilar',
                          :dni        => '25101854',
                          :mobile     => '3416505478',
                          :car        => 'Chevrolet Cobalt 2014',
                          :car_color  => 'Azul',
                          :car_license=> 'NNQ-946', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Gastón',
                          :last_name  => 'Petinari',
                          :dni        => '29583007',
                          :mobile     => '3413822085',
                          :car        => 'Chevrolet Meriva 2006',
                          :car_color  => 'Azul oscuro',
                          :car_license=> 'ETC-650', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Gustavo Ariel',
                          :last_name  => 'Yarros',
                          :dni        => '26719728',
                          :mobile     => '3416922700',
                          :car        => 'Citroen C4 Lounge 2016',
                          :car_color  => 'Blanco Nacarado',
                          :car_license=> 'AA487BS', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Juan Carlos',
                          :last_name  => 'Vetrone',
                          :dni        => '6062371',
                          :mobile     => '3415020494',
                          :car        => 'Renault Fluence 2015',
                          :car_color  => 'Blanco',
                          :car_license=> 'MGO-104', :car_seats => 4)
    end
  end
end
