class DropKanbanBoardsTable < ActiveRecord::Migration
  def change
    drop_table :kanban_tasks
  end
end
