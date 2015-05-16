class ChangePriorityToInteger < ActiveRecord::Migration
  def change
    change_column :tasks, :priority, 'integer USING CAST(priority AS integer)'
  end
end
