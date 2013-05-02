require 'net/http'

class UserPhoto < ActiveRecord::Base
  attr_accessible :user_id, :url

  belongs_to :user

  before_destroy :delete_filepicker_image

  validates :url, :user, presence: true
  validates :user_id, uniqueness: true

  def delete_filepicker_image
    expiry = Time.now.to_i + 30 # expires in 30 seconds
    json = {expiry: expiry, call: "remove"}.to_json
    policy = Base64::urlsafe_encode64(json)
    digest = OpenSSL::Digest::Digest.new('sha256')
    signature = OpenSSL::HMAC.hexdigest(digest, APP_CONFIG['filepicker_secret'], policy)
    url = URI.parse("#{self.url}?apikey=#{APP_CONFIG['filepicker_api_key']}&policy=#{policy}&signature=#{signature}")
    req = Net::HTTP.new(url.host)
    req.delete("#{url.path}?#{url.query}")
  end
end
