class AddDescriptionToProject < ActiveRecord::Migration
  def up
  	add_column "projects","description", :text
  end

  def down
  	remove_column "projects","description", :text
  end
end
