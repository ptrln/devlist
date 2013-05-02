class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_id, null: false
      t.integer :to_id, null: false
      t.boolean :is_read, default: false
      t.text :body, null: false
      t.integer :chain_id, null: false
      t.timestamps
    end
    add_index :messages, :from_id
    add_index :messages, :to_id
    add_index :messages, :chain_id
  end
end
