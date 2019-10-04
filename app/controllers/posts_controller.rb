class PostsController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
	before_action :confirm_logged_in, :except =>[:index,:forgot_collegeid,:forgot,:signup,:show,:login,:attempt_ulogin,:logout,:validate,:register,:forgot_form]
	def index
		@users= Post.all
	end
	def forgot

		
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
      redirect_to  booking_path,success: "You are now logged in & present in booking section!!"
    else
      redirect_to login_path, danger: "Invalid Login Credentials!!"
    end
  end
  
  def logout
    session[:user_id]=nil
    session[:collegeid]=nil
    redirect_to home_path,info: "Logged out!!"
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

