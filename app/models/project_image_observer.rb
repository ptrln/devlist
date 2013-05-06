class ProjectImageObserver < ActiveRecord::Observer
  def after_create(project_image)
    project_image.project.notifications.create(message: "New image uploaded for #{project.title}")
  end
end
