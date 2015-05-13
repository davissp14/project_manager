class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :error, :success

  helper_method :current_project
  def current_project
    @project ||= if params[:controller] == 'projects'
      Project.find_by_slug(params[:id])
    else
      Project.find_by_slug(params[:project_id])
    end
  end

  helper_method :current_milestone
  def current_milestone
    @milestone ||= if params[:controller] == 'milestones'
      current_project.milestones.find_by_slug(params[:id])
    else
      current_project.milestones.find_by_slug(params[:milestone_id])
    end
  end
end
