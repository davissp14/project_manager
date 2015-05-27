class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :board_id
      t.string :title

      t.timestamps null: false
    end
  end
end
