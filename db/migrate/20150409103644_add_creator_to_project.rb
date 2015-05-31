class AddCreatorToProject < ActiveRecord::Migration
  def up
  	add_column "projects","creator", :integer
  end

  def down
  	remove_column "projects","description", :integer
  end
end
