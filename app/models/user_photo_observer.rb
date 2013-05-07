class UserPhotoObserver < ActiveRecord::Observer
  def after_create(photo)
    current_user.notifications.create(message: "#{current_user.screen_name} has uploaded a new profile photo")
  end
end
