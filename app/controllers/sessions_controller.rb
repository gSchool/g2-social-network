class SessionsController < ApplicationController
  def destroy
    log_user_out
    redirect_to root_path, notice: "You have been logged out"
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      log_user_in(@user.id)
      flash[:login_message] = "Welcome back #{@user.email}"
      redirect_to '/users'
    else
      render '/users'
    end
  end
end
