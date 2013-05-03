class UserProfileObserver < ActiveRecord::Observer
  def after_save(profile)
    if profile.changed.length > 0
      p "profile changes"
      p profile.changed
    end
  end
end
