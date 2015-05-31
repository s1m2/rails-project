class User < ActiveRecord::Base

  def admin
        return role == 'admin'
    end

    def leader
        return role == 'Project Leader'
    end

    def member
        return role == 'Project Member'
    end


 
  has_secure_password
  belongs_to :project
  belongs_to :project_activity
  has_many :conversations, :foreign_key => :sender_id

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9._-]+\.[a-z]{2,4}\Z/i

  validates :first_name, :presence => true,
                         :length => {:maximum => 25}
   validates :lastname, :presence => true,
                         :length => {:maximum => 25}
   validates :email, :presence => true,
                     :length => {:maximum => 100},
                     :format => EMAIL_REGEX,
                     :confirmation => true,
                     :uniqueness => true

   validates :department, :presence => true,
                          :length => {:maximum=>20}
   validates :role, :presence => true,
                          :length => {:maximum=>20}
   validates :username, :presence => true,
	                     :length => {:within => 8..25},
	                     :uniqueness => true
	
end
