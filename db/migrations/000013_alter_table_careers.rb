Sequel.migration do
  up do
    add_column :careers, :full_description, String
  end

  down do
    drop_column :careers, :full_description
  end
end
