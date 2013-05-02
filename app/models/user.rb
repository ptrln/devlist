class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable,
         :confirmable, 
         :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :screen_name, 
                  :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me,
                  :user_profile_attributes, 
                  :skills_attributes, 
                  :contacts_attributes,
                  :follower_ids,
                  :following_user_ids,
                  :following_project_ids

  has_one :photo, :class_name => "UserPhoto", :dependent => :destroy

  has_many :github_panels, :inverse_of => :user

  has_one :user_profile, :inverse_of => :user, :dependent => :destroy
  accepts_nested_attributes_for :user_profile, :reject_if => :all_blank, :allow_destroy => true

  has_many :projects, :class_name => "UserProject", :inverse_of => :user, :dependent => :destroy
  #accepts_nested_attributes_for :projects, :reject_if => :all_blank

  has_many :skills, :class_name => "UserSkill", :inverse_of => :user, :dependent => :destroy
  accepts_nested_attributes_for :skills, :allow_destroy => true, :reject_if => :all_blank

  has_many :contacts, :class_name => "UserContact", :inverse_of => :user, :dependent => :destroy
  accepts_nested_attributes_for :contacts, :reject_if => :all_blank, :allow_destroy => true

  has_many :verified_contacts, :class_name => "UserVerifiedContact", :inverse_of => :user, :dependent => :destroy
 
  has_many :follows, :class_name => "Follow", :as => :followable, :dependent => :destroy
  has_many :followers, :through => :follows
  has_many :following, :class_name => "Follow", foreign_key: "follower_id"
  has_many :following_users, :through => :following, :source =>  :followable, :source_type => 'User'
  has_many :following_projects, :through => :following, :source =>  :followable, :source_type => 'UserProject'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :screen_name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }
  validate :screen_name_not_reserved

  def profile
    user_profile || UserProfile.new
  end

  def to_param
    screen_name
  end

  def screen_name_not_reserved
    if RESERVED_WORDS.has_key?(screen_name)
      errors[:screen_name] = "is not available"
    end
  end
end
