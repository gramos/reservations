# coding: utf-8
module DBSeed

  class Drivers
    def self.run!
      DB[:drivers].insert(:first_name => 'Nestor',
                          :last_name  => 'Farina',
                          :dni        => '123456',
                          :mobile     => '',
                          :car        => '',
                          :car_color  => '',
                          :car_license=> '', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Marcelo',
                          :last_name  => 'Bissuti',
                          :dni        => '123456',
                          :mobile     => '',
                          :car        => '',
                          :car_color  => '',
                          :car_license=> '', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Andres',
                          :last_name  => 'Ricci',
                          :dni        => '123456',
                          :mobile     => '',
                          :car        => '',
                          :car_color  => '',
                          :car_license=> '', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Ariel',
                          :last_name  => 'Aguilar',
                          :dni        => '123456',
                          :mobile     => '',
                          :car        => '',
                          :car_color  => '',
                          :car_license=> '', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Gastón',
                          :last_name  => 'Petinari',
                          :dni        => '123456',
                          :mobile     => '',
                          :car        => '',
                          :car_color  => '',
                          :car_license=> '', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Fredy',
                          :last_name  => 'Fredy',
                          :dni        => '123456',
                          :mobile     => '',
                          :car        => '',
                          :car_color  => '',
                          :car_license=> '', :car_seats => 4)

      DB[:drivers].insert(:first_name => 'Juan Carlos',
                          :last_name  => 'Carlos',
                          :dni        => '123456',
                          :mobile     => '',
                          :car        => '',
                          :car_color  => '',
                          :car_license=> '', :car_seats => 4)

    end
  end
end
