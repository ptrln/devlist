module UserProjectsHelper
  def correct_path_for_project
    @project = UserProject.includes(:user).find(params[:id])
    @user = User.find_by_screen_name([params[:user_id]])
    project_not_found unless @project && @user && @project.user == @user
  end

  def project_not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
