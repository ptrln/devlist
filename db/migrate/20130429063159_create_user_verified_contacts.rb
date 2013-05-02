class CreateUserVerifiedContacts < ActiveRecord::Migration
  def change
    create_table :user_verified_contacts do |t|
      t.string :t, null: false
      t.string :info, null: false
      t.text :auth, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :user_verified_contacts, :user_id
  end
end
