class MembersController < ApplicationController

	layout 'member'

	def index
		@project = Project.last
	  	@users = User.where.not("id = ?",current_user.id).order("created_at DESC")
	  	@projectactivity = @project.project_activities.where("assignee_id =?",current_user.id).last
	    @conversations = Conversation.all
	end
end
