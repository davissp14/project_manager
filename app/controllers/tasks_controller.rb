class TasksController < ApplicationController

  def new
    @task = project.tasks.new 
  end

  def index
    @tasks = project.tasks.order('priority ASC')
  end

  def create
    @task = project.tasks.new(tasks_params)

    if @task.valid?
      @task.save
      redirect_to project_tasks_path(project, @task)
    else
      render :new
    end
  end

  def show 

  end

  def update

  end

   def sort
    project = Project.find_by_name(params[:project_id])
    params[:order].each do |key,value|
      project.tasks.find(value[:id]).update_attribute(:priority, value[:position])
    end
    render :nothing => true
  end

  private 

  def tasks_params
    params.require(:task).permit(:name, :description)
  end

  def project
    @project = Project.find_by_name(params[:project_id])
  end

end
