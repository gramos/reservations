Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :first_name,     :null => false
      String :last_name,      :null => false
      String :dni,            :null => true
      String :username, :null => false
      String :crypted_password, :null => false
    end
  end

  down do
    drop_table(:users)
  end
end
