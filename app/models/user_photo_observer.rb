class UserPhotoObserver < ActiveRecord::Observer
  def after_create(photo)
    current_user.notifications.create(message: "#{photo.user.screen_name} has uploaded a new profile photo")
  end
end
