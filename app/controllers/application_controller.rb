class ApplicationController < ActionController::Base
  protect_from_forgery
  include AnalyticsHelper
  include FilepickerHelper

  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if resource.user_profile.nil?
      edit_profile_path
    elsif resource.class == User
      user_path(resource)
    elsif request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
end
