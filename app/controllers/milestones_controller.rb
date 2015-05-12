class MilestonesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @milestones = current_project.milestones.all
  end

  def new
    @milestone = current_project.milestones.new
  end

  def create 
    @milestone = current_project.milestones.new(milestones_params)

    if @milestone.valid?
      @milestone.save
      redirect_to project_milestones_path(current_project, @milestone)
    else
      render :new
    end
  end

  def show
    @milestone = current_project.milestones.find_by_title(params[:id])
    @tasks = params[:status] ? @milestone.tasks.where(status: params[:status]) : @milestone.tasks
  end

  private

  def milestones_params
    params.require(:milestone).permit(:title, :scope)
  end

end
