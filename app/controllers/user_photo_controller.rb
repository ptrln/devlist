class UserPhotoController < ApplicationController
  before_filter :authenticate_user!

  def create
    if current_user.photo
      current_user.photo.destroy
    end
    current_user.create_photo(params[:user_photo])
    render :json => {status: "ok"}
  end

  def destroy
    if current_user.photo
      current_user.photo.destroy
    end
    render :json => {status: "ok"}
  end
end
