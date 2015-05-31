class AdminController < ApplicationController
	layout 'admin'
	def index
		@users = User.all

	end

	def create
		@user = User.new
	end

	def save
		@user = User.new(user_params)
        UserMailer.notification(@user).deliver
  	    if @user.save
	      flash[:notice] = 'Signup Successfull You Can Now Login'
	  		redirect_to(:controller =>'admin/users')
  	   else
  		 render('admin/create')
  	   end
	end

	def users
		@users = User.where.not("id = ?",current_user.id)
	end

	def delete
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			flash[:notice] = "User #{@user.first_name} deleted successfully"
			redirect_to(:action=>'index')
	    else
	    	flash[:notice] = "User #{@user.first_name} could not be deleted successfully"
	    	render('destroy')
	    end
	end

	 private

  def user_params
  	 params.require(:user).permit(:first_name,:lastname,:email,:department,:role,:username,:password)
  end
end
