class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    task = current_project.tasks.find(params[:task_id])
    task.comments.create(comments_params.merge(user_id: current_user.id))

    redirect_to project_task_path(current_project, task)
  end

  private

  def comments_params
    params.require(:comment).permit(:text, :user_id)
  end
end
