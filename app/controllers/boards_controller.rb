class BoardsController < ApplicationController


  def index 
    kanban = current_project.kanbans.find(params[:kanban_id])
    
    respond_to do |format|
      format.json { render json: kanban.boards.to_json(include: [:cards]) }
    end 
  end

  def create 
    kanban = current_project.kanbans.find(params[:kanban_id])
    board = kanban.boards.create!(name: params[:name])

    boards = kanban.reload.boards

    respond_to do |format|
      format.json { render json: boards.to_json(include: [:cards]) }
    end 
  end


end
