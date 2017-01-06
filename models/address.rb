class Address < Sequel::Model

  many_to_one :customer

  def full
    str = "#{street} #{number} "
    str += "<br /><b>Torre: </b>#{tower} " unless tower.to_s.empty?
    str += "<b>Piso: </b>#{floor} " unless floor.to_s.empty?
    str += "<b>Dpto: </b>#{apartment}" unless apartment.to_s.empty?
    str
  end
end
