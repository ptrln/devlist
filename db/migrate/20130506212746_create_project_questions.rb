class CreateProjectQuestions < ActiveRecord::Migration
  def change
    create_table :project_questions do |t|
      t.integer :project_id, null: false
      t.string :body, null: false
      t.integer :asker_id, null: false

      t.timestamps
    end
    add_index :project_questions, :project_id
    add_index :project_questions, :asker_id
  end
end
