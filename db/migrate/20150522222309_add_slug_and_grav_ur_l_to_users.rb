class AddSlugAndGravUrLToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_column :users, :profile_icon, :string 
  end
end
