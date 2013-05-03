class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.string :followable_type, null: false
      t.integer :followable_id, null: false
      t.integer :follower_id, null: false
      t.timestamps
    end
    add_index :follows, :follower_id
    add_index :follows, [:followable_type, :followable_id]
    add_index :follows, [:followable_type, :followable_id, :follower_id], unique: true, name: 'follows_combo_index'
  end
end
