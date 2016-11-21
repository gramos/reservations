Sequel.migration do
  up do
    create_table(:scheduled_times) do
      primary_key   :id
      String :day, :null => false
      Time :time,  :null => false

      foreign_key :city_id, :cities
    end
  end

  down do
    drop_table(:scheduled_times)
  end
end
