class ProjectImageObserver < ActiveRecord::Observer
  def after_create(project_image)
    project_image.project.notifications.create(
      message: "New image uploaded for #{project_image.project.title}"
    ) if project_image.project
  end
end
