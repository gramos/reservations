Sequel.migration do
  up do
    create_table(:cities) do
      primary_key :id
      String :name, :null => false
    end
  end

  down do
    drop_table(:cities)
  end
end
