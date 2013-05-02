module FilepickerHelper
  def filepicker_view_policy
    "eyJleHBpcnkiOjk5OTk5OTk5OTksImNhbGwiOlsicmVhZCIsImNvbnZlcnQiXX0="
  end

  def filepicker_view_signature
    "15ca477ec906ede20e36aa2413e19ccb5aacf2b9b0b7cd3c216410e3f159daaf"
  end

  def filepicker_view
    "?signature=15ca477ec906ede20e36aa2413e19ccb5aacf2b9b0b7cd3c216410e3f159daaf&policy=eyJleHBpcnkiOjk5OTk5OTk5OTksImNhbGwiOlsicmVhZCIsImNvbnZlcnQiXX0="
  end

  def filepicker_project_view(w, h)
    p "depreciate this"
    filepicker_crop_view(w, h)
  end

  def filepicker_crop_view(w, h)
    "/convert?w=#{w}&h=#{h}&fit=crop&signature=15ca477ec906ede20e36aa2413e19ccb5aacf2b9b0b7cd3c216410e3f159daaf&policy=eyJleHBpcnkiOjk5OTk5OTk5OTksImNhbGwiOlsicmVhZCIsImNvbnZlcnQiXX0="
  end

  def store_image_auth
    expiry = Time.now.to_i + 30 * 60 # expires in half an hour
    json = {expiry: expiry, call: "store", maxsize: 1024*1024*3}.to_json
    @policy = Base64::urlsafe_encode64(json)
    digest = OpenSSL::Digest::Digest.new('sha256')
    @signature = OpenSSL::HMAC.hexdigest(digest, APP_CONFIG['filepicker_secret'], @policy)
  end
end
