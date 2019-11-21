class PostsController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
	before_action :confirm_logged_in, :except =>[:index,:forgot_collegeid,:forgot,:signup,:show,:login,:attempt_ulogin,:logout,:validate,:register,:forgot_form]
	def index
		@users= Post.all
	end
	def forgot

		
	end
	def bookingdelete
    @order = Booking.find(params[:id])
    @veg = Vegetable.find_by(veg_name: @order.veg_name)
    @veg.update_attributes(:quantity => @veg.quantity+@order.quantity.to_f)
    if @veg.save
    	@order.destroy
    	redirect_to booking_path(session[:collegeid])
   	end
  	end
	def forgot_form
		@mail = forgotparams[:email]
		@fuser = Post.where(:email => @mail).first
		if @fuser==nil
			redirect_to forgot_path, danger: "Email_id not found in users list!!"
		else
			UserMailer.forgot(@fuser).deliver_now
			redirect_to login_path, info: "Check your email for login credentials"
		end

	end
	def signup
		 @post = Post.new
    end
    def show
		redirect_to signup_path, success: "User Created Succesfully!!"
	end
	def booking
		clgid = session[:collegeid]
		@booking=Booking.new
		@buser = Post.where(:collegeid => clgid).first
		@total_price= 0.0
      		@temp= Booking.where(:colege_id=> session[:collegeid])
      		@temp.each do |list|
      			@total_price = @total_price + list.price.to_f
      		end
      		#render plain: @total_price.inspect
	
	end
	def book_veg
	@buser = Post.where(:collegeid => session[:collegeid]).first
    @booking=Booking.new(bookingparams)
    username = session[:collegeid]
    found_user = Post.where(:collegeid => username).first
    found_veg = Vegetable.where(:veg_name => @booking.veg_name).first
    if found_user && found_veg
      @booking.update_attributes(:colege_id => found_user.collegeid ,:name =>  found_user.name,:phone =>  found_user.phone,:address =>found_user.address, :price => (found_veg.price*@booking.quantity.to_i))
      if @booking.save
      	if @booking.quantity=='0'
      		@booking.destroy
    		redirect_to booking_path(session[:collegeid]),danger: "Quantity Can't be Zero and Your Order was Not Placed!!"
    		return
    	end
    	found_veg1 = Vegetable.where(:veg_name => @booking.veg_name).first
      	if @booking.quantity.to_i <= found_veg1.quantity
      		#render plain: found_veg1.inspect
      		found_veg1.update_attributes(:quantity => found_veg1.quantity - @booking.quantity.to_i)
      		redirect_to booking_path(session[:collegeid]), success: "Vegetable Ordered successfully!!"
      	else
      		@booking.destroy
      		redirect_to booking_path(session[:collegeid]), warning: "Order not placed because you Ordered excess quantity!!"
      	end
      else
        render '/posts/booking'
      end 
    else
      flash[:danger] = "Parameters for Book Vegetables are wrong  (or)  Vegetable not Found.  Please try again!!"
      render '/posts/booking'
    end

    
   # render plain: @booking.inspect
  end
	def login

	end
	def attempt_ulogin
  	username=uloginparams[:collegeid]
  	password=uloginparams[:password]
  	if username.present? && password.present?
      found_user = Post.where(:collegeid => username).first
     if found_user
        authorized_user = found_user.authenticate(uloginparams[:password])
      end
    end
    if authorized_user
      # TODO: mark user as logged in
      session[:user_id]=authorized_user.id
      session[:collegeid]=authorized_user.collegeid
      @blacklist = Blacklist.find_by(colege_id: session[:collegeid])
      if @blacklist.blank?
      redirect_to  booking_path(session[:collegeid]),success: "Hi #{session[:collegeid]}, Welcome to Booking Section.."
      else
       redirect_to  home_path(session[:collegeid]),danger: "#{session[:collegeid]} Was Blocked by Vibhav Please Contact Vibhav for further details!!" 
     end
    else
      redirect_to login_path, danger: "Invalid Login Credentials!!"
    end
  end
  
  def logout
    session[:user_id]=nil
    session[:collegeid]=nil
    redirect_to home_path,info: "Logged out!!"
  end
  def confirm
    clgid = session[:collegeid]
    @fuser = Post.where(:collegeid => clgid).first
    @mail = @fuser.email
    if @fuser==nil
      redirect_to home_path, danger: "Invalid Credentials!!"
    else
      UserOrderMailer.confirmation(@fuser).deliver_now
      redirect_to home_path, success: "Check your email for Boooking details!!"
    end
  end
	def cancel

	end
	
	def register
		@post=Post.new(regparams)
		if @post.password==@post.confirm_password
			if @post.save
    		redirect_to @post
  			else
   				render 'signup'
   			end
   		else
   			flash[:danger] = "password & confirm_password doesn't match!!"
   			render 'signup'
   		end

	end
	
	private
	def regparams
		params.require(:post).permit(:collegeid, :name, :dept, :type, :course, :phone, :address, :password,:email,:confirm_password)
	end
	def validateparams
		params.require(:valid).permit(:cid)
	end
	def uloginparams
		params.require(:ulogin).permit(:collegeid,:password)
	end
	def forgotparams
		params.require(:forgot).permit(:email)
	end
	 def bookingparams
    params.require(:book_vegs).permit(:veg_name,:quantity)
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

