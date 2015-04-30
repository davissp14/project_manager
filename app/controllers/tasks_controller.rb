class TasksController < ApplicationController

  def new
    @task = current_project.tasks.new 
  end

  def index
    @tasks = current_project.tasks.order('priority ASC')
  end

  def create
    @task = current_project.tasks.new(tasks_params)

    if @task.valid?
      @task.save
      redirect_to project_tasks_path(current_project, @task)
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    @comment = @task.comments.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(tasks_params)

    redirect_to project_tasks_path(current_project)
  end

   def sort
    params[:order].each do |key,value|
      current_project.tasks.find(value[:id]).update_attribute(:priority, value[:position])
    end
    render :nothing => true
  end

  private 

  def tasks_params
    params.require(:task).permit(:name, :description, :status)
  end
end
