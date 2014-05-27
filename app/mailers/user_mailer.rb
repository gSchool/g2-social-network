class UserMailer < ActionMailer::Base
  default from: "confirmation@bradtkesbook.com"

  def welcome_email(user)
    @user = user
    @url  = '/login'
    mail(to: @user.email, subject: "Welcome to Bradtke's Book!")
  end

end
