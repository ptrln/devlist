module DashboardHelper
  def notification_user_icon(update)  # of notifiable type
    if update.notifiable_type == "User"
      update.notifiable.photo ? (update.notifiable.photo.url + filepicker_crop_view(30, 30)) : "default_user_thumb.png"
    elsif update.notifiable_type == "UserProject"
      if update.notifiable.images.length > 0
        return update.notifiable.images.first.url + filepicker_crop_view(30, 30)
      else
        update.notifiable.user.photo ? (update.notifiable.user.photo.url + filepicker_crop_view(30, 30)) : "default_user_thumb.png"
      end
    end
  end
end
