Sequel.migration do
  up do
    alter_table(:choices) do
    add_foreign_key :outcome_id, :outcomes
    end
  end
  down do
    drop_column :choices, :outcome_id
  end
end