Sequel.migration do
  up do
    create_table(:customers) do
      primary_key :id
      String :first_name,     :null => false
      String :last_name,      :null => false
      String :dni,            :null => false
      Date   :birthday,       :null => false
      String :phone_number,   :null => true
      String :mobile,         :null => false
     
      foreign_key :address_id, :addresses
   end  
  end  
end  
