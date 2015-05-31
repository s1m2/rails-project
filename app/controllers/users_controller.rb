class UsersController < ApplicationController
	layout :determine_layout
	before_action :confirmed_logged_in
	before_action :find_user
	def index
		@users = User.where.not("id = ?",current_user.id)
	end

	def edit
		@user = User.find(params[:user_id])
	end

	def update
	@user = User.find(params[:user_id])

	  	if @user.update_attributes(user_params)
	      flash[:notice] = 'Changes saved Successfull'
	  		redirect_to(:action =>'edit')
	  	else
	  		render('edit')
	  	end
    end

	private

	def find_user
		if params[:user_id]
			@user = User.find(params[:user_id])
		end
	end

	def user_params
  	 params.require(:user).permit(:first_name,:lastname,:email,:department,:role,:username,:password)
  end
end
