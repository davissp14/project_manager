class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :project_id
      t.integer :task_id
      t.text :text

      t.timestamps null: false
    end
  end
end
