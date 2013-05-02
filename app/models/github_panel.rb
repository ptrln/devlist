class GithubPanel < ActiveRecord::Base
  attr_accessible :language_count_json,  
                  :user_id, 
                  :login,
                  :url,
                  :public_repos,
                  :total_repos,
                  :followers,
                  :following,
                  :github_created_at,
                  :github_updated_at


  belongs_to :user
  belongs_to :verified_github, class_name: "UserVerifiedContact"

  validates :user, :language_count_json, :login, :url, :public_repos, 
    :total_repos, :followers, :following, :github_created_at, 
    :github_updated_at, presence: true
  validates :verified_github_id, presence: true, uniqueness: true
end