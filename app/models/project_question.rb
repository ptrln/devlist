class ProjectQuestion < ActiveRecord::Base
  attr_accessible :body, :asker_id, :project_id

  belongs_to :project, class_name: "UserProject"
  belongs_to :asker, class_name: "User"

  validates :body, :project, :asker, presence: true

end
