class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|

      t.integer :owner_id
      t.string :name

      t.timestamps null: false
    end
  end
end
