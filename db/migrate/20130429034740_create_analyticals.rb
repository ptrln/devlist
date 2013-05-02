class CreateAnalyticals < ActiveRecord::Migration
  def change
    create_table :analyticals do |t|
      t.string :page_path, null: false
      t.integer :exits, null: false
      t.integer :pageviews, null: false
      t.integer :visitors, null: false
      t.integer :new_visits, null: false
      t.integer :entrances, null: false
      t.integer :unique_pageviews, null: false
      t.float :time_on_page, null: false

      t.timestamps
    end
    add_index :analyticals, :page_path, :unique => true
  end
end
