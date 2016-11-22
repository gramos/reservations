Sequel.migration do
  up do
    create_table(:scheduled_times) do
      primary_key    :id
      Integer :day,  :null => false
      String  :time, :null => false

      foreign_key :city_id, :cities
    end
  end

  down do
    drop_table(:scheduled_times)
  end
end
