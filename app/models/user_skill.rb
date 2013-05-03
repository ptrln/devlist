class UserSkill < ActiveRecord::Base
  attr_accessible :name, :proficiency

  belongs_to :user

  default_scope order('proficiency DESC')

  validates :name, presence: true
  validates :proficiency, presence: true
  validates :user, presence: true

end
