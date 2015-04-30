class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :error, :success

  helper_method :current_project
  def current_project
    @project ||= if params[:controller] == 'projects'
      Project.find_by_name(params[:id])
    else
      Project.find_by_name(params[:project_id])
    end
  end
end
