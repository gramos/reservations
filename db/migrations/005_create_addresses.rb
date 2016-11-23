Sequel.migration do
  up do
    create_table(:addresses) do
      primary_key :id
      String  :street,      :null => false
      String  :apartment,   :null => true
      String  :tower,       :null => true 
      String  :floor,       :null => true
      String  :number,      :null => true
      Integer :zone,        :null => true 

      foreign_key :city_id, :cities
    end
  end

  down do
    drop_table(:addresses)
  end
end

