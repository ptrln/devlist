class UserProfilesController < ApplicationController
  include FollowableHelper
  before_filter :authenticate_user!, except: 
    [:show, :followers, :project_followers, :following, :project_following]

  def show
    @user = User.find_by_screen_name(params[:id]) || user_not_found
    @stat = google_analytics(request.fullpath)
  end

  def edit
    @user = current_user
    if @user.user_profile.nil?
      @new_user = true
      @user.build_user_profile 
    end
    3.times { @user.projects.build }
    3.times { @user.skills.build }
    3.times { @user.contacts.build }
    store_image_auth
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to "/" + current_user.screen_name
    else
      store_image_auth
      @user = current_user
      render :edit
    end
  end

  def user_not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def follow
    @user = User.find_by_screen_name(params[:id]) || user_not_found
    followable(@user)  unless @user == current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {status: "ok"} }
    end
  end

  def unfollow
    @user = User.find_by_screen_name(params[:id]) || user_not_found
    unfollowable(@user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {status: "ok"} }
    end
  end

  def followers
    @user = User.find_by_screen_name(params[:id]) || user_not_found
  end

  def project_followers
    @user = User.find_by_screen_name(params[:id]) || user_not_found
  end

  def following
    @user = User.find_by_screen_name(params[:id]) || user_not_found
  end

  def project_following
    @user = User.find_by_screen_name(params[:id]) || user_not_found
  end

end
