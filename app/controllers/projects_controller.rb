class ProjectsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @project = Project.new
  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by_name(params[:id])
  end

  def create
    @project = Project.new(project_params)

    if @project.valid?
      @project.save
      flash[:success] = "Project successfully created"
      redirect_to @project
    else
      flash[:notice] = @project.error_messages.first
      render :new
    end
  end

  private 

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
  