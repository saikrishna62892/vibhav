class UserOrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_order_mailer.confirmation.subject
  #
  def confirmation(user)
    @user = user
    @total_price= 0.0
      		@temp= Booking.where(:colege_id=> @user.collegeid)
      		@temp.each do |list|
      			@total_price = @total_price + list.price.to_f
      		end
    mail to: @user.email, subject: "Order details of #{@user.name}" 
  end
end
