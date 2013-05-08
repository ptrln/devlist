class UserCss < ActiveRecord::Base
  attr_accessible :css, :user_id

  belongs_to :user

  VALID_CSS_REGEX = /^((\/\*[^\/]*\*\/)*\s*(([.#]?([a-zA-Z_0-9-]+|>) *)+\{\s*(((([a-zA-Z-])+\ *\:[^;]+;)|(\/\*[^\/]*\*\/))*\s*)*\})+\s*)*\s*$/

  validates :user, presence: true
  validates :user_id, presence: true, uniqueness: true
  validates :css, presence: true, format: { with: VALID_CSS_REGEX }
end
