class UpdateTaskController < ApplicationController
	
    before_action :confirmed_logged_in
	before_action :find_project_activity
	layout :determine_layout

	def update
		@projectactivity = ProjectActivity.find(params[:projectactivity_id])
	end


	def save
		@projectactivity = ProjectActivity.find(params[:projectactivity_id])
		if @projectactivity.update_attributes(update_params)
			redirect_to(:controller=>'notifications/show',:projectactivity_id=>@projectactivity.id)
		else
			render('update')
		end
	end

	private

	def find_project_activity
		if params[:id]
			@projectactivity = ProjectActivity.find(params[:id])
		end
	end

	def update_params
		params.require(:project_activity).permit(:completed)
	end
end
