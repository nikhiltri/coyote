class AddAssignmentsCountToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :assignments_count, :integer, default: 0
  end
end
