class SessionsController < ApplicationController
  def destroy
    log_user_out
    redirect_to root_path, notice: "You have been logged out"
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      log_user_in(@user)
      flash[:login_message] = "Welcome back #{@user.email}"
      redirect_to '/users'
    else
    flash[:login_error] = "Invalid login"
      render "/login/index"
    end
  end
end
