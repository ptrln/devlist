class UserProjectObserver < ActiveRecord::Observer
  def after_save(project)
    if project.changed.length > 0
      project.notifications.create(message: "Project '#{project.title}' has been updated: <br>#{project.changed.inspect}")
    end
  end
end
