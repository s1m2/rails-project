class Project < ActiveRecord::Base
	
	has_many :users
	has_many :project_activities

   validates :project_name, :presence => true,
                         :length => {:maximum => 25}
   validates :start_date, :presence => true,
                         :length => {:maximum => 50}
   validates :end_date, :presence => true,
                          :length => {:maximum=>50}
   validates :creator, :presence => true,
                          :length => {:maximum=>20}
   validates :description, :presence => true

end
