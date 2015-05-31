class UserMailer < ActionMailer::Base
  layout 'mail'
  default from: "admin@workflo.com"

  def notification(user)
  	 @user = user
  	 mail(:to => @user.email, :subject => "User Details")
  end

  def passwordrecovery(user,password)
  	 @user = user
  	 @password = password
  	 mail(:to => @user.email, :subject => "Password Recovery")
  end
end
