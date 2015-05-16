class DropMilestones < ActiveRecord::Migration
  def change
    drop_table :milestones 
    remove_column :tasks, :milestone_id 
  end
end
