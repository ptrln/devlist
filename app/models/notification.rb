class Notification < ActiveRecord::Base
  attr_accessible :notifiable_type, :notifiable_id, :message
  belongs_to :notifiable, :polymorphic => true

  validates :notifiable, :message, presence: true

  def self.latest_for_user(user)
    following_user_ids = user.following_user_ids
    following_project_ids = user.following_project_ids
    
    if following_user_ids.length > 0 && following_project_ids.length > 0
      Notification.where("(notifiable_type = 'User' AND notifiable_id IN (#{following_user_ids.join(',')})) OR (notifiable_type = 'UserProject' AND notifiable_id IN (#{following_project_ids.join(',')}))").all
    elsif following_project_ids.length > 0
      Notification.where("notifiable_type = 'UserProject' AND notifiable_id IN (#{following_project_ids.join(',')})").all
    elsif following_user_ids.length > 0
      Notification.where("notifiable_type = 'User' AND notifiable_id IN (#{following_user_ids.join(',')})").all
    else
      []
    end
    # if following_project_ids.length > 0 && following_user_ids.length > 0
    #   Notification.where(
    #     "(notifiable_type = ? AND notifiable_id IN ?) OR (notifiable_type = ? AND notifiable_id IN ?)", 
    #     "User", 
    #     user.following_user_ids, 
    #     "UserProject", 
    #     user.following_project_ids
    #   ).all
    # elsif following_user_ids.length > 0
    #   Notification.where(
    #     "notifiable_type = ? AND notifiable_id IN ?", 
    #     "User", 
    #     user.following_user_ids
    #   ).all
    # elsif following_project_ids.length > 0
    #   Notification.where(
    #     "notifiable_type = ? AND notifiable_id IN ?", 
    #     "UserProject", 
    #     user.following_project_ids
    #   ).all
    # else
    #   []
    # end
  end
end