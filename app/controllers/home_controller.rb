class HomeController < ApplicationController
  layout 'dashboard'
  
  before_action :confirmed_logged_in
  
  def index
  	@project = Project.last
  	@users = User.where.not("id = ?",current_user.id).order("created_at DESC")
  	
    @conversations = Conversation.all
  end
  
end
