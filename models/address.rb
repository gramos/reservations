class Address < Sequel::Model

  many_to_one :customer

  def full
    "<b>Calle:</b> #{street} <br /><b>Numero:</b>#{number} <br/>" +
    "<b>Torre:</b>#{tower} <b>Piso:</b>#{floor} <b>Dpto:</b>#{apartment}"
  end


end
