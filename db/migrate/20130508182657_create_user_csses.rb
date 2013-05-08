class CreateUserCsses < ActiveRecord::Migration
  def change
    create_table :user_csses do |t|
      t.integer :user_id, null: false
      t.text :css, null: false

      t.timestamps
    end

    add_index :user_csses, :user_id, unique: true
  end
end
