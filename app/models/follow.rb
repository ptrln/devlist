class Follow < ActiveRecord::Base
  attr_accessible :followable_type, :followable_id, :follower_id

  belongs_to :followable, :polymorphic => true
  belongs_to :follower, class_name: "User"

  validates :followable, :follower, presence: true

  def self.destroy(followable, follower_id)
    Follow.where({followable_type: followable.class.name, followable_id: followable.id, follower_id: follower_id}).destroy_all
  end
end
