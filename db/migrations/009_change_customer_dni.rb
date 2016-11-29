Sequel.migration do
  up do
    run('ALTER TABLE customers ALTER COLUMN dni DROP NOT NULL')
  end

  down do
    run('ALTER TABLE customers ALTER COLUMN dni SET NOT NULL')
  end
end
