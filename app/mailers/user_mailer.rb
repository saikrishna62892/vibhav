class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot.subject
  #
  def forgot(user)
    @user = user

    mail to: @user.email, subject: "Login Credentials for #{@user.name}"
  end
end
