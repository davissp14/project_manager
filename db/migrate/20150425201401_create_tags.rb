class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|

      t.integer :project_id
      t.integer :task_id
      t.string :name

      t.timestamps null: false
    end
  end
end
