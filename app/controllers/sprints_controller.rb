class SprintsController < ApplicationController

  def index
    @sprints = current_project.sprints
  end

  def new
    @sprint = current_project.sprints.new
  end

  def create
    @sprint = current_project.sprints.new(sprints_params)
    @sprint.save

    redirect_to project_sprints_path(current_project)
  end

  def show
    @sprint = current_project.sprints.find(params[:id])
  end

  private 

  def sprints_params
    params.require(:sprint).permit(:name, :target_date, :description)
  end

end
