class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :project_id
      t.integer :owner_id
      t.string :status
      t.string :name
      t.text :description
      t.date :target_date


      t.timestamps null: false
    end
  end
end
