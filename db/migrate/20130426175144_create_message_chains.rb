class CreateMessageChains < ActiveRecord::Migration
  def change
    create_table :message_chains do |t|
      t.string :user1, null: false
      t.string :user2, null: false
      t.date :user1_last_read
      t.date :user2_last_read
    end

    add_index :message_chains, :user1
    add_index :message_chains, :user2
    add_index :message_chains, [:user1, :user2], unique: true
  end
end
