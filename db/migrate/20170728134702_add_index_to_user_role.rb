class AddIndexToUserRole < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :role
  end
end
