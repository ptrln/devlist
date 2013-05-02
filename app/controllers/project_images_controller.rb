class ProjectImagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    if params[:project_image][:project_id] && !params[:project_image][:project_id].empty?
      project = UserProject.find(params[:project_image][:project_id])
      if project && project.user == current_user
        image = ProjectImage.create(params[:project_image])
        render :json => image
      else
        render :json => {status: 'forbidden'}, status: 403
      end
    else
      image = ProjectImage.create(params[:project_image])
      render :json => image
    end
  end

  def destroy
    fail
    #TODO

  end
end
