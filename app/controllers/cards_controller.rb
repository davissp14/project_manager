class CardsController < ApplicationController

  def index
    kanban = current_project.kanbans.find(params[:kanban_id])

    respond_to do |format|
      format.html
      format.json { render json: kanban.boards.to_json(include: [:cards]) }
    end
  end

  def create
    kanban = current_project.kanbans.find(params[:kanban_id])
    boards = kanban.boards.find(params[:board_id])

    card = boards.cards.create!(title: params[:title])

    respond_to do |format|
      format.json { render json: card.to_json }
    end
  end

  def update 
    kanban = current_project.kanbans.find(params[:kanban_id])
    board = kanban.boards.find(params[:board_id])

    card = Card.find(params[:id])
    card.update_attributes(board_id: board.id, title: params.fetch(:title, card.title)) 

    respond_to do |format|
      format.json { render json: board.cards.to_json }
    end
  end

  def destroy
    kanban = current_project.kanbans.find(params[:kanban_id])
    board = kanban.boards.find(params[:board_id])

    card = board.cards.find(params[:id])
    card.destroy

    respond_to do |format|
      format.json { render json: board.cards.to_json}
    end
  end
end
