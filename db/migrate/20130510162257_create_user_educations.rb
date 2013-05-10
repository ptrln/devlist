class CreateUserEducations < ActiveRecord::Migration
  def change
    create_table :user_educations do |t|
      t.string :school, null: false
      t.string :degree, null: false
      t.string :gpa, null: false
      t.text :description, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :user_educations, :user_id
  end
end
