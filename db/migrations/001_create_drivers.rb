Sequel.migration do
  up do
    create_table(:drivers) do
      primary_key :id
      String  :first_name,  :null => false
      String  :last_name,   :null => false
      String  :dni,         :null => false
      String  :mobile,      :null => true
      String  :car,         :null => true
      Integer :car_seats,   :null => false
      String  :car_color,   :null => true
      String  :car_license, :null => true
    end
  end

  down do
    drop_table(:drivers)
  end
end
