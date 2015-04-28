class MilestonesController < ApplicationController

  def index
    @project = Project.find_by_name(params[:project_id])
    @milestones = @project.milestones.all
  end

  def new
    @project = Project.find_by_name(params[:project_id])
    @milestone = @project.milestones.new
  end

  def create 
    @project = Project.find_by_name(params[:project_id])
    @milestone = @project.milestones.new(milestones_params)

    if @milestone.valid?
      @milestone.save
      redirect_to project_milestones_path(@project, @milestone)
    else
      render :new
    end
  end


  private

  def milestones_params
    params.require(:milestone).permit(:title, :scope)
  end

end
