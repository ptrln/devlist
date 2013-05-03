class ProjectImageObserver < ActiveRecord::Observer
  def after_create(project_image)
    project_image.project.notifications.create(message: "Project image uploaded")
  end
end
