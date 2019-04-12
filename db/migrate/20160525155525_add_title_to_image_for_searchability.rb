class AddTitleToImageForSearchability < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :title, :text
  end
end
