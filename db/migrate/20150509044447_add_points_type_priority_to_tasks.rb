class AddPointsTypePriorityToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :points, :integer
    add_column :tasks, :type, :string 
    change_column :tasks, :priority, :string
  end
end
