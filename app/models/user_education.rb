class UserEducation < ActiveRecord::Base
  attr_accessible :school, :degree, :gpa, :user_id, :description, :graduate_date

  belongs_to :user

  validates :school, :degree, presence: true
end
