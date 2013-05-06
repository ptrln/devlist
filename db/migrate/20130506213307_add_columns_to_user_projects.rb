class AddColumnsToUserProjects < ActiveRecord::Migration
  def change
    add_column :user_projects, :link, :string
    add_column :user_projects, :source_link, :string
  end
end
