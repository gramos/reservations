Sequel.migration do
  up do
    create_table(:reservation_types) do
      primary_key :id
      String  :name,  :null => false
      Float   :price, :null => false
      Integer :seats, :null => true
    end
  end

  down do
    drop_table :reservation_types
  end
end  
