class KanbansController < ApplicationController

  def index
    @kanbans = current_project.kanbans
  end

  def new
    @kanban = current_project.kanbans.new
  end

  def create
    @kanban = current_project.kanbans.new(kanbans_params)
    @kanban.save

    redirect_to project_kanbans_path(current_project)
  end

  def show
    @kanban = current_project.kanbans.find(params[:id])
    @tasks = @kanban.kanban_tasks
    
    add_breadcrumb '<strong>kanban details</strong>'.html_safe
  end

  def toggle_task
 
  end

  private 

  def kanbans_params
    params.require(:kanban).permit(:name, :target_date, :description, :status)
  end

end
