Sequel.migration do
  up do
    alter_table(:scheduled_times) do
      add_column :custom, TrueClass, :default => false
    end
  end

  down do
    alter_table(:scheduled_times) do
      drop_column :custom
    end
  end

end
