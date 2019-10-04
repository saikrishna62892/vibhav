class AdminController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
	before_action :confirm_logged_in, :except =>[:index,:attempt_login,:logout,:forgot_password]
  

  def index
   
  end
  def edit
  end
  def delete
    @veg = Vegetable.find(vegparams[:id])
    @veg.destroy
    redirect_to add_path
  end
  def add
    @vegetable = Vegetable.new
  end
  def add_veg
    @vegetable=Vegetable.new(vegparams)
    if @vegetable.save
        redirect_to add_path, success: "Vegetable added successfully!!"
        else
          render 'add'
        end
  end
  def status
  end
  def blaclist
  end
  def forgot_password
    redirect_to admin_path, info: "Please Contact the Developer for Password!!"
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
  private
  def adminparams
		params.require(:adminlogin).permit(:adminid,:password)
	end
  private
  def vegparams
    params.require(:vegetable).permit(:veg_name,:quantity,:price)
  end
	private
	def confirm_logged_in
		unless session[:user_id]
			redirect_to home_path, warning: "Please Login!!"
			return false
		else
			return true
		end
	end
end
