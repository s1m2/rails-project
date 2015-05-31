class ProgressController < ApplicationController
	
	before_action :confirmed_logged_in

	layout :determine_layout
	
	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
		@projectactivities = @project.project_activities
	end
end
