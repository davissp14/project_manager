class AddSlugToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :slug, :string
  end
end
