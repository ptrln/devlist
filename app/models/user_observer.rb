class UserObserver < ActiveRecord::Observer

  def before_save(user)
    unless user.user_profile.nil? || user.user_profile.changed.empty?
      user.notifications.create(message: "#{user.screen_name} has updated their profile: #{user.user_profile.changed.join(', ')}")
    end
  #   if user.photo.changed?
  #      p "photo changes"
  #   end
  #   if user.skills_changed?
  #     p "skills changed"
  #   end
  #   if user.contacts_changed?
  #     p "contacts changed"
  #   end
  #   if user.verified_contacts_changed?
  #     p "verified contact chnages"
  #   end
  #   if followers_changed?
  #     p "followers changed"
  #   end
  # end
  end
end
