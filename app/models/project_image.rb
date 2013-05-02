require 'net/http'

class ProjectImage < ActiveRecord::Base
  attr_accessible :ordering, :project_id, :url

  belongs_to :project

  before_destroy :delete_filepicker_image

  validates :ordering, :url, presence: true

  default_scope order('ordering ASC')

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
