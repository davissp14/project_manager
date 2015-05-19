class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_breadcrumbs

  add_flash_types :error, :success

  helper_method :current_account
  def current_account
    @current_account ||= current_user.account
  end

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

  private 

  def set_breadcrumbs
    if %w(tasks hackpads kanbans feeds).include?(params[:controller])
      add_breadcrumb "projects", projects_path(current_project)
      add_breadcrumb "#{params[:controller]}".html_safe, Rails.application.routes.url_helpers.send("project_#{params[:controller]}_path", current_project)
    end
  end
end
