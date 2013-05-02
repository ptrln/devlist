class CreateProjectImages < ActiveRecord::Migration
  def change
    create_table :project_images do |t|
      t.string :url, null: false
      t.integer :ordering, null: false
      t.integer :project_id

      t.timestamps
    end

    add_index :project_images, :project_id
  end
end
