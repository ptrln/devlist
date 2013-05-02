class UserVerifiedContact < ActiveRecord::Base
  attr_accessible :info, :t, :auth

  belongs_to :user
  has_many :github_panels, :inverse_of => :verified_github, :foreign_key => "verified_github_id"

  default_scope order('t ASC, created_at ASC')

  validates :t, presence: true
  validates :info, :auth, presence: true
  validates :user, presence: true
end
