class ProjectsController < ApplicationController
	
	before_action :confirmed_logged_in
    
    before_action :current_user

	layout :determine_layout
	def index
		@projects = Project.where("creator=?",current_user.id)
	end

	def new
		@project = Project.new
	end

	def show
		@project = Project.find(params[:project_id])
		@projectactivities = @project.project_activities.where("project_id = ?",params[:project_id])
	end

	def create
		@project = Project.new(project_params)
		@project.creator = current_user.id
		if @project.save
			flash[:notice] = "New project created successfully"
			redirect_to(:action=>'index')
		else
            render('new')
        end
	end
	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:project_id])
		
		if @project.update_attributes(project_params)
			flash[:notice] = "Project Updated successfully"
			redirect_to(:action=>'show',:project_id=>@project.id)
		else
			render('edit')
		end
	end

	def delete
		@project = Project.find(params[:id])
	end

	def destroy
		@project = Project.find(params[:id])
		if @project.destroy
			flash[:notice] = "Project #{@project.project_name} deleted successfully"
			redirect_to(:action=>'index')
	    else
	    	flash[:notice] = "Project #{@project.project_name} could not be deleted successfully"
	    	render('destroy')
	    end
	end

	private

	def project_params
	   params.require(:project).permit(:project_name,:start_date,:end_date,:description)
	end
end
