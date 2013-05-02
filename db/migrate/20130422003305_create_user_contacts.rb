class CreateUserContacts < ActiveRecord::Migration
  def change
    create_table :user_contacts do |t|
      t.string :t
      t.string :info
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :user_contacts, :user_id
  end
end
