class TasksController < ApplicationController

  def new
    @task = current_project.tasks.new 
  end

  def index
    if params.has_key?(:filter)
      @tasks = current_project.tasks.order('priority ASC').select{|task| task.status == params[:filter] }
    else
      @tasks = current_project.tasks.order('priority ASC')
    end

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
    @task = current_project.tasks.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(tasks_params)
    redirect_to project_tasks_path(current_project)
  end

  def toggle_status
    task = Task.find(params[:task_id])
    
    target_status = task.status == 'open' ? 'closed' : 'open'
    task.update_attributes(status: target_status)

    redirect_to project_task_path(current_project, task)
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
