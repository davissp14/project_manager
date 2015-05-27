class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    task = current_project.tasks.find(params[:task_id])

    respond_to do |format|
      format.json { render json: task.comments.to_json(include: [:user] ) }
    end
  end

  def create
    task = current_project.tasks.find(params[:task_id])
    task.comments.create(comments_params.merge(user_id: current_user.id))

    respond_to do |format|
      format.json { render json: task.comments.to_json(include: [:user] ) }
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text, :user_id)
  end
end
