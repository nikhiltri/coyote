class MoveTitleToCaption < ActiveRecord::Migration[5.0]
  def change
    Description.all.each do |d|
      d.metum_id = 2
      d.save!
    end
  end
end
