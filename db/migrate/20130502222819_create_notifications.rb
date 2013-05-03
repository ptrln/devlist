class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notifiable_type, null: false
      t.integer :notifiable_id, null: false
      t.string :message, null: false
      t.timestamps
    end
    add_index :notifications, [:notifiable_id, :notifiable_type]
  end
end
