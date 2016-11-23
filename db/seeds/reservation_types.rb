# coding: utf-8
module DBSeed

  class ReservationTypes
    def self.run!
      %w(Comun Paquete Abonox20 Abonox40 Sobre).each do |t|
        DB[:reservation_types].insert(
           :name => t, :price => 100
        )
      end
    end
  end
end
