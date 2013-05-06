class CreateProjectUpdates < ActiveRecord::Migration
  def change
    create_table :project_updates do |t|
      t.integer :project_id, null: false
      t.string :body, null: false
      t.timestamps
    end
  end
end
