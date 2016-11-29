Sequel.migration do
  up do
    add_column :addresses, :phone_number, String
  end

  down do
    drop_column :addresses, :phone_number
  end
end
