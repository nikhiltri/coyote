class RemoveCaptions < ActiveRecord::Migration[5.0]
  def change
    Metum.where(title: "Caption").each do |m|
      d = Description.where(metum: m)
      d.each{|de| de.delete}
      m.delete
    end
  end
end
