class AdminController < ApplicationController
  add_flash_types :danger,:info, :success,:warning
  before_action :confirm_logged_in, :except =>[:index,:attempt_login,:logout,:forgot_password]
  
  def index
   
  end
  def reg_users
    @users = Post.all
  end
  def delete
    @veg = Vegetable.find(params[:id])
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
  def edit
    @edit = Vegetable.find(params[:id])
  end
  def update
    @edit =Vegetable.find(params[:id])
 
    if @edit.update(vegparams)
      redirect_to add_path
    else
      render 'edit'
    end

  end
  def status
  end
  def closeshop 
    
    ActiveRecord::Base.connection.execute("INSERT INTO blacklists (colege_id) SELECT distinct colege_id FROM bookings")
    Booking.delete_all
    redirect_to blacklist_path
  end
  def status_done
    @order = Booking.find(params[:id])
    if @order.destroy
    redirect_to status_path,success: "Order marked as Delivered!!"
  else
    redirect_to status_path,danger: "Some Error Occured, Please Try Again!!"
  end
  end
  def user_remove
    @order = Blacklist.find(params[:id])
    if @order.destroy
    redirect_to blacklist_path,success: "User removed from Blacklist!!"
  else
    redirect_to blacklist_path,danger: "Some Error Occured, Please Try Again!!"
  end
  end
  def forgot_password
    redirect_to admin_path, info: "Please Contact the Developer for Password!!"
  end
  def attempt_login
    username=adminparams[:adminid]
    password=adminparams[:password]
    if username.present? && password.present?
      found_user = Admin.find_by(:adminid => username)
    if username=="Vibhav" && password=="vibhav"
      # TODO: mark user as logged in
      session[:user_id]=found_user.id
      session[:adminid]=found_user.adminid
      redirect_to  add_path,success: "You are now logged in!!"
    else
      redirect_to admin_path, danger: "Invalid Login Credentials!!"
    end
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
  def editparams
    params.require(:edits).permit(:veg_name,:quantity,:price)
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
