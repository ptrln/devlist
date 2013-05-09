class UserProjectsController < ApplicationController
  include UserProjectsHelper
  include FollowableHelper

  before_filter :correct_path_for_project, except: [:new, :create]
  before_filter :authenticate_user!, except: [:show]
  before_filter :authorized_user, except: [:show, :new, :create, :follow, :unfollow]

  def new
    @project = UserProject.new
    store_image_auth
  end

  def create
    @project = current_user.projects.build(params[:user_project])
    if @project.save
      redirect_to user_project_path(current_user, @project)
    else
      store_image_auth
      render :new
    end
  end

  def edit
    store_image_auth
  end

  def update
    if @project.update_attributes(params[:user_project])
      redirect_to user_project_path(current_user, @project)
    else
      store_image_auth
      render :edit
    end
  end

  def show
    @stat = google_analytics(request.fullpath)
  end

  def destroy
    @project.destroy
    redirect_to user_path(@user)
  end

  def authorized_user
    if current_user.screen_name != params[:user_id]
      redirect_to root_path
    else
      project = UserProject.find(params[:id])
      unless project.user.id == current_user.id 
        redirect_to root_path
      end
    end
  end

  def correct_path_for_project
    @project = UserProject.includes(:user).find(params[:id])
    @user = User.find_by_screen_name([params[:user_id]])
    project_not_found unless @project && @user && @project.user == @user
  end

  def project_not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def follow
    followable(@project) unless @user == current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {status: "ok"} }
    end
  end

  def unfollow
    unfollowable(@project)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {status: "ok"} }
    end
  end
end
