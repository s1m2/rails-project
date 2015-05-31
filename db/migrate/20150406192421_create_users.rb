class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "first_name", :limit => 50
      t.string "lastname", :limit => 50
      t.string "email", :limit => 100
      t.string "department", :limit => 40
      t.string "role", :limit => 50
      t.string "username", :limit => 50
      t.string "password", :limit => 100
      t.timestamps
    end
  end
end
