class ProjectActivitiesController < ApplicationController
	
    before_action :confirmed_logged_in
	before_action :find_project
	layout :determine_layout
	def index
		@projects = Project.all
	end

	def new
		@projects = Project.find(params[:project_id])
		@users = User.where.not("id = ? OR role=?",current_user.id,"admin").order("created_at DESC")
		@project_activity = ProjectActivity.new
	end

	def save
		@project = Project.find(params[:project_id])
		@project_activity = ProjectActivity.new(project_activity_params)
		@project_activity.asignor_id = current_user.id
		@project_activity.project_id = @project.id
		if @project_activity.save
			flash[:notice] = "Task Assigned successfully"
			redirect_to(:controller=>'projects/show',:project_id=>@project.id)
		else
			render('new')
		end
	end

	def edit
		@project_activity = ProjectActivity.find(params[:projectactivity_id])
		@project = Project.find(params[:project_id])
		@users = User.where.not("id = ?",current_user.id).order("created_at DESC")
	end

	def update
		@project_activity = ProjectActivity.find(params[:projectactivity_id])
		@project = Project.find(params[:project_id])
		if @project_activity.update_attributes(project_activity_params)
			flash[:notice] = "Task Updated successfully"
			redirect_to(:controller=>'projects/show',:project_id=>@project.id)
		else
			render('edit')
		end
	end

	def delete
		@project_activity = ProjectActivity.find(params[:projectactivity_id])
		@project = Project.find(params[:project_id])
	end

	def destroy
		@project_activity = ProjectActivity.find(params[:projectactivity_id])
		@project = Project.find(params[:project_id])
		if @project_activity.destroy
			flash[:notice] = "Task #{@project_activity.task} successfully deleted from #{@project.project_name}"
			redirect_to(:controller=>'projects/show',:project_id=>@project.id)

		else
			render('delete')
		end
		
	end

	private

	def find_project
		if params[:project_id]
			@project = Project.find(params[:project_id])
		end
	end

	def project_activity_params
		params.require(:project_activity).permit(:task,:activity,:assignee_id)
	end
end
