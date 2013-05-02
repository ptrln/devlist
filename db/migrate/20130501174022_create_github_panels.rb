class CreateGithubPanels < ActiveRecord::Migration
  def change
    create_table :github_panels do |t|
      t.integer :user_id, null: false
      t.integer :verified_github_id, null: false
      t.string :language_count_json, null: false
      t.string :login, null: false
      t.string :url, null: false
      t.integer :public_repos, null: false
      t.integer :total_repos, null: false
      t.integer :followers, null: false
      t.integer :following, null: false
      t.datetime :github_created_at, null: false
      t.datetime :github_updated_at, null: false

      t.timestamps
    end
    add_index :github_panels, :user_id
    add_index :github_panels, :verified_github_id, unique: true
  end
end
