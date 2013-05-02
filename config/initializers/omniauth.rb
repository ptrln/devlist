Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, APP_CONFIG['twitter_key'], APP_CONFIG['twitter_secret']
  provider :facebook, '435189683242343', '71188d4f7f51b33cd09407d1f3962cc3'
  provider :linkedin_oauth2, 'v57v3vmadpwh', 'V9PWVbcdro5dCoJ5', :scope => 'r_fullprofile'
  provider :github, APP_CONFIG['github_key'], APP_CONFIG['github_secret']
end