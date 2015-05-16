class ProjectsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @project = current_account.projects.new

    add_breadcrumb "projects", projects_path(@project)
    add_breadcrumb "<strong>new</strong>".html_safe
  end

  def index
    @projects = current_account.projects
  end

  def show
    @project = current_account.projects.find_by_name(params[:id])
  end

  def create
    @project = current_account.projects.new(project_params)

    @project.save
    redirect_to project_feed_path(@project)
  end

  private 

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
  