class CreateProjectActivities < ActiveRecord::Migration
  def change
    create_table :project_activities do |t|
      t.integer :project_id
      t.integer :asignor_id
      t.integer :assignee_id
      t.text    :task
      t.text    :activity
      t.timestamps
    end

    add_index("project_activities","project_id")
    add_index("project_activities","asignor_id")
    add_index("project_activities","assignee_id")
  end
end
