class CreateHackpads < ActiveRecord::Migration
  def change
    create_table :hackpads do |t|
      t.string :pad_id
      t.integer :project_id
      t.string :title
      t.timestamps null: false
    end
  end
end
