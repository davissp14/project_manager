class DropKanbanTasksTable < ActiveRecord::Migration
  def change
    drop_table :kanban_boards
  end
end
