class UserProfile < ActiveRecord::Base
  attr_accessible :headline, :name, :summary, :template

  belongs_to :user
  validates :user, presence: true
end
