class PostsController < ApplicationController
	add_flash_types :danger,:info, :success,:warning
	def index
		@users= Post.all
	end
	def forgot_collegeid
	end
	def forgot_password
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
      redirect_to  booking_path,success: "You are now logged in!!"
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
	def validate
		@validate=validateparams[:cid]	
		#@record=Post.find_by collegeid: @validate
		render plain:@validate.inspect
		#render plain:@record.inspect
		##if @validate.collegeid==college
		#	redirect_to order_path
		#else
		#	redirect_to signup_path, danger: "Invalid Credentials Registration Required!!"
		#end
	end
	def order
	end
	def register
		@post=Post.new(regparams)
		 if @post.save
    		redirect_to @post
  		else
   			render 'signup'
   		end
	end
	
	private
	def regparams
		params.require(:post).permit(:collegeid, :name, :dept, :type, :course, :phone, :address, :password)
	end
	def validateparams
		params.require(:valid).permit(:cid)
	end
	def uloginparams
		params.require(:ulogin).permit(:collegeid,:password)
	end
end

