class ProjectAnswer < ActiveRecord::Base
  attr_accessible :body, :project_id

  belongs_to :project, class_name: "UserProject"

  validates :body, :project, presence: true
end