class AdminController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
  def login
  end

  def index
   
  end
  def forgot_password
  	
  end
  def attempt_login
  	username=adminparams[:adminid]
  	password=adminparams[:password]
  	if username.present? && password.present?
      found_user = Admin.where(:adminid => username).first
     if found_user
        authorized_user = found_user.authenticate(adminparams[:password])
      end
    end
    if authorized_user
      # TODO: mark user as logged in
      session[:user_id]=authorized_user.id
      session[:adminid]=authorized_user.adminid
      redirect_to  add_path,success: "You are now logged in!!"
    else
      redirect_to admin_path, danger: "Invalid Login Credentials!!"
    end
  end
  
  def logout
    session[:user_id]=nil
    session[:adminid]=nil
    redirect_to home_path,info: "Logged out!!"
  end
  def adminparams
		params.require(:adminlogin).permit(:adminid,:password)
	end
end
