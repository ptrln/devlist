class Notification < ActiveRecord::Base
  attr_accessible :notifiable_type, :notifiable_id, :message
  belongs_to :notifiable, :polymorphic => true

  validates :notifiable, :message, presence: true

  default_scope order('created_at DESC LIMIT 20')

  def self.latest_for_user(user)
    following_user_ids = user.following_user_ids
    following_project_ids = user.following_project_ids
  
    notify = Notification.select("*, created_at > '#{user.notification_time ? user.notification_time : "2000-05-07 00:50:03"}' AS is_unread")
    user.notification_time = Time.now
    user.save
    if following_user_ids.length > 0 && following_project_ids.length > 0
      notify.where("(notifiable_type = 'User' AND notifiable_id IN (#{following_user_ids.join(',')})) OR (notifiable_type = 'UserProject' AND notifiable_id IN (#{following_project_ids.join(',')}))").all
    elsif following_project_ids.length > 0
      notify.where("notifiable_type = 'UserProject' AND notifiable_id IN (#{following_project_ids.join(',')})").all
    elsif following_user_ids.length > 0
      notify.where("notifiable_type = 'User' AND notifiable_id IN (#{following_user_ids.join(',')})").all
    else
      []
    end
  end
end