class NotificationsController < ApplicationController
	
	before_action :confirmed_logged_in
	layout :determine_layout
	def index
		@projectactivities = ProjectActivity.where("assignee_id = ?",current_user.id)
	end

	def show
		@projectactvity = ProjectActivity.find(params[:projectactivity_id])
	end
end
