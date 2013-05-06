class UserProject < ActiveRecord::Base
  attr_accessible :creation_date, 
                  :description, 
                  :summary, 
                  :technologies, 
                  :title, 
                  :images_attributes,
                  :follower_ids,
                  :link,
                  :source_link

  belongs_to :user
  has_many :images, class_name: "ProjectImage", foreign_key: "project_id", 
    :inverse_of => :project, :dependent => :destroy
  accepts_nested_attributes_for :images, reject_if: :all_blank

  has_many :notifications, :as => :notifiable, :dependent => :destroy

  has_many :follows, :as => :followable
  has_many :followers, :through => :follows

  validates :title, presence: true
  validates :user, presence: true

  def to_param
    if title.nil?
      id
    else
      "#{id}-#{title.downcase.gsub(/[^a-zA-Z0-9]+/, "_")}"
    end
  end

end
