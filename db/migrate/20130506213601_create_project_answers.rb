class CreateProjectAnswers < ActiveRecord::Migration
  def change
    create_table :project_answers do |t|
      t.integer :question_id, null: false
      t.string :body, null: false

      t.timestamps
    end
    add_index :project_answers, :question_id
  end
end
