class ProjectActivity < ActiveRecord::Base
	
	has_many :users
	belongs_to :project

	validates :project_id, :presence => true,
                         :length => {:maximum => 25}
   validates :asignor_id, :presence => true,
                         :length => {:maximum => 50}
   validates :task, :presence => true,
                          :length => {:maximum=>50}
   validates :activity, :presence => true,
                          :length => {:maximum=>1220}
   validates :assignee_id, :presence => true
   validates :completed, :presence => true
end
