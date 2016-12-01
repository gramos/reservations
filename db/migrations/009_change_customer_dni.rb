Sequel.migration do
  up do
    run('ALTER TABLE customers ALTER COLUMN dni DROP NOT NULL')
  end

end
