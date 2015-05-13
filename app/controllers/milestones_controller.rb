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
    #TODO This is redundant
    if params.has_key?(:status)
      @tasks = current_milestone.tasks.where(status: params[:status]).order('priority_status DESC')
    else
      params[:status] = 'open'
      @tasks = current_milestone.tasks.where(status: 'open').order('priority_status DESC')
    end
  end

  private

  def milestones_params
    params.require(:milestone).permit(:title, :scope)
  end

end
