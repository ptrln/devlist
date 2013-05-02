class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|
      t.integer :user_id, :null => false
      t.string :title, :null => false
      t.date :creation_date
      t.string :summary
      t.text :description
      t.string :technologies

      t.timestamps
    end

    add_index :user_projects, :user_id
  end
end
