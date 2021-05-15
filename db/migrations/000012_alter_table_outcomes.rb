Sequel.migration do
  up do
    alter_table(:outcomes) do
    add_foreign_key :choice_id, :choices, :null=>false 
    end
    alter_table(:outcomes) do
    add_foreign_key :career_id, :careers, :null=>false 
    end
  end

  down do
    drop_column :outcomes, :career_id
  end
  down do
    drop_column :outcomes, :choice_id
  end
end