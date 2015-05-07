class CommentsController < ApplicationController

  def create
    task = current_project.tasks.find(params[:task_id])
    task.comments.create(comments_params)

    redirect_to project_task_path(current_project, task)
  end


  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
