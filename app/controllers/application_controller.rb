class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActionController::RoutingError, :with => :render_not_found
  protect_from_forgery with: :exception

  protect_from_forgery with: :null_sessions

  def confirmed_logged_in
    unless session[:user_id]
      flash[:notice] = "Please Log in."
      redirect_to(:controller => 'access',:action=>'login')
      return false
    end
      return true
  end
  
  def determine_layout
    if current_user.leader
      "dashboard"
    elsif current_user.member
       "member"
    elsif current_user.admin
      "admin"
    end
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
  
  def generate_random_password
   length = 10
   chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
   password = ''
   length.times { |i| password << chars[rand(chars.length)] }
   password
  end

  def authenticate_user
    if !current_user
      redirect_to signin_path, notice: "You must be signed in to do that!"
    end
  end

  helper_method :current_user, :authenticate_user
  
  private
  def render_not_found
   render "#{Rails.root}/public/404.html", :status => 404
  end

  
end
