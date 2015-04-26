class AddColorHexToTags < ActiveRecord::Migration
  def change
    add_column :tags, :color_hex, :string
  end
end
