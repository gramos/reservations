Sequel.migration do
  up do
    alter_table(:services) do
      add_column :programmed, TrueClass, :default => true
    end
  end

  down do
    alter_table(:services) do
      drop_column :programmed
    end
  end

end
