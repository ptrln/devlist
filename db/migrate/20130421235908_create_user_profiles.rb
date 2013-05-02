class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.string :headline
      t.text :template
      t.text :summary
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :user_profiles, :user_id, :unique => true
  end
end
