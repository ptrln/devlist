class CreateUserPhotos < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.string :url, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :user_photos, :user_id, unique: true
  end
end
