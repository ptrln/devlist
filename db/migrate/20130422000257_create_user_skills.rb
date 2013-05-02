class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.string :name, :null => false
      t.integer :proficiency, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :user_skills, :user_id
  end
end
