class RenameGroupsToContexts < ActiveRecord::Migration[5.0]
  def change
    rename_table :groups, :contexts
  end
end
