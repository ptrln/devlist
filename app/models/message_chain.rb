class MessageChain < ActiveRecord::Base
  attr_accessible :user1, :user1_last_read, :user2, :user2_last_read

  has_many :messages, foreign_key: "chain_id"

  validates :user1, :user2, presence: true

  def self.find_or_create_for(user1, user2)
    ids = [user1.screen_name, user2.screen_name].sort
    chain = where("user1 = ? AND user2 = ?", ids[0], ids[1]) 
    chain.empty? ? self.create!(user1: ids[0], user2: ids[1]) : chain.first
  end

  def self.find_for(user1, user2)
    ids = [user1.screen_name, user2.id.screen_name].sort
    self.where("user1 = ? AND user2 = ?", ids[0], ids[1]).first
  end

  def self.find_all_for(user)
    self.where("user1 = ? OR user2 = ?", user.screen_name, user.screen_name).all
  end
end
