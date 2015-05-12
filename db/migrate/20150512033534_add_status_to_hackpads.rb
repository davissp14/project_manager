class AddStatusToHackpads < ActiveRecord::Migration
  def change
    add_column :hackpads, :status, :string, default: 'active'
  end
end
