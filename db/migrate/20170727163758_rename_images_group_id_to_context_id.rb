class RenameImagesGroupIdToContextId < ActiveRecord::Migration[5.0]
  def change
    rename_column :images, :group_id, :context_id
  end
end
