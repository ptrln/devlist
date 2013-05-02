class UserContact < ActiveRecord::Base
  attr_accessible :info, :t

  belongs_to :user

  validates :t, presence: true
  validates :info, presence: true
  validates :user, presence: true
end
