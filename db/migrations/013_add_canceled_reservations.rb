Sequel.migration do
  up do
    alter_table(:reservations) do
      add_column :canceled, TrueClass, :default => false
    end
  end

  down do
    alter_table(:reservations) do
      drop_column :canceled
    end
  end

end
