class RenameSprintsTable < ActiveRecord::Migration
  def change
    rename_table :sprints, :kanbans
  end
end
