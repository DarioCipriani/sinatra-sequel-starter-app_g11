Sequel.migration do
  up do
    alter_table(:responses) do
      add_foreign_key :question_id, :questions, null: false
    end
    alter_table(:responses) do
      add_foreign_key :choice_id, :choices, null: false
    end
    alter_table(:responses) do
      add_foreign_key :survey_id, :surveys, null: false
    end
  end

  down do
    drop_column :responses, :choice_id
  end
  down do
    drop_column :responses, :survey_id
  end
  down do
    drop_column :responses, :question_id
  end
end
