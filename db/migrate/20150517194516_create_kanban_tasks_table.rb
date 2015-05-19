class CreateKanbanTasksTable < ActiveRecord::Migration
  def change
    create_table :kanban_tasks do |t|
      t.integer :project_id
      t.integer :kanban_id
      
      t.string :name
      t.string :status
      t.string :task_type
      t.text :description
      
    end
  end
end
