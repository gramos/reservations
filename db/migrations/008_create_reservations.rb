Sequel.migration do
  up do
    create_table(:reservations) do
      primary_key :id
      String  :quantity,  :null => false

      foreign_key :service_id,   :services
      foreign_key :type_id,      :reservation_types
      foreign_key :customers_id, :customers
      foreign_key :address_id,   :addresses
    end
  end

  down do
    drop_table(:reservations)
  end
end
