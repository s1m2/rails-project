class AddCompletedToProjectActivities < ActiveRecord::Migration
  def up
  	add_column "project_activities", "completed", :integer, :default => 0
  end

  def down
  	remove_column "project_activities", "completed", :integer, :default => 0
  end
end
