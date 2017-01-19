Sequel.migration do
  up do
    alter_table(:reservations) do
      add_column :created_at, DateTime
    end
  end

  down do
    alter_table(:reservations) do
      drop_column :created_at
    end
  end

end
