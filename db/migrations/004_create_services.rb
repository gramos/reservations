Sequel.migration do
  up do
    create_table(:services) do
      primary_key   :id
      Date :date,   :null   => false

      foreign_key :driver_id, :drivers
      foreign_key :scheduled_times_id, :scheduled_times
    end
  end

  down do
    drop_table(:services)
  end
end
