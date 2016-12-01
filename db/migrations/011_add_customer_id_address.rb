Sequel.migration do
  up do
    alter_table(:addresses) do
      add_foreign_key :customer_id, :customers
    end

    alter_table(:customers) do
      drop_column :address_id
    end
  end

  down do
    alter_table(:addresses) do
      drop_column :customer_id
    end
  end

end
