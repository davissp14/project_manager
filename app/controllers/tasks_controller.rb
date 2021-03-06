class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = current_project.tasks.new 
    add_breadcrumb 'new'.html_safe
  end

  def index
    @tasks = current_project.tasks.order('priority ASC')
  end

  def create
    @task = current_project.tasks.new(tasks_params.merge(user_id: current_user.id))

    if @task.valid?
      @task.save
      redirect_to project_tasks_path(current_project, @task)
    else
      render :new
    end
  end

  def show
    @task = current_project.tasks.find(params[:id])
    add_breadcrumb 'task'.html_safe
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(tasks_params)
    redirect_to project_task_path(current_project, task)
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

  def assign
    task = current_project.tasks.find(params[:id])
    task.update_attributes(owner: current_user)

    redirect_to project_task_path(current_project, task)
  end

  def unassign 
    task = current_project.tasks.find(params[:id])
    task.update_attributes(owner: nil)

    redirect_to project_task_path(current_project, task)
  end

  private 

  def tasks_params
    params.require(:task).permit(:name, :description, :status, :points, :task_type, :priority, :user_id, :priority_status)
  end

end
