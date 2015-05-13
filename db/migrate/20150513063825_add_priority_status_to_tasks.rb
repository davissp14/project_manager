class AddPriorityStatusToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :priority_status, :integer, default: 2
  end
end
