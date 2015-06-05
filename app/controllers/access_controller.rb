class AccessController < ApplicationController

  layout 'login'

  before_action :confirmed_logged_in, :except =>[:login,:attempt_login,:signup,:create,:forgot,:password_reset,:logout]

  def index
  	#display text & links
  end

  def login
  end

  def attempt_login
  	if params[:username].present? && params[:password].present?
  		found_user = User.where(:username => params[:username]).first
  		if found_user
  			authorized_user = found_user.authenticate(params[:password])
  		end
  	end
  	if authorized_user
  		session[:user_id] = authorized_user.id
  		session[:username] = authorized_user.username
      if authorized_user.leader
        redirect_to(:controller => 'home/index')
      elsif authorized_user.member
        redirect_to(:controller => 'members/index')
      elsif authorized_user.admin
        redirect_to(:controller => 'admin/index')
      end
  		
  	else
  		flash[:notice] = "Incorrect combination of username or password"
  		redirect_to(:action => 'login')

  	end
  	  
  end

  def signup
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    UserMailer.notification(@user).deliver
  	if @user.save
      flash[:notice] = 'Signup Successfull You Can Now Login'
  		redirect_to(:controller =>'admin/users')
  	else
  		render('admin/create')
  	end
  end

  def logout
  	session[:user_id] = nil
  	session[:username] = nil
  	redirect_to(:action => 'login')
  end

  def forgot
  end

 
  def password_reset
   if params[:email].present?
     found_user=User.where(:email => params[:email]).first
     if found_user
       password = generate_random_password
       updatepwd = found_user.update_attributes(:password => password)
       UserMailer.passwordrecovery(found_user,password).deliver
       flash[:notice] = "Email sent successfully"
       redirect_to(:action=>'login')
     else
       flash[:notice] = "User Not Found in The Database"
       render('forgot')
     end
   else
     flash[:notice] = "Email cannot be blank"
     render('forgot')
   end
  end


  private

  def user_params
  	 params.require(:user).permit(:first_name,:lastname,:email,:department,:role,:username,:password)
  end
end
