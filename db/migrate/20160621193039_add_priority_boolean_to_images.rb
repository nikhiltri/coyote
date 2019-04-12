class AddPriorityBooleanToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :priority, :boolean, default: false
  end
end
