class SessionsController < ApplicationController
  def destroy
    log_user_out
    redirect_to root_path, notice: "You have been logged out"
  end

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      if user.confirmation
      log_user_in(user)
      flash[:login_message] = "Welcome back #{user.email}"
      redirect_to '/users'
      else
        redirect_to "/login/confirmation/#{user.id}"
      end
    else
      flash[:failed_login] = "Invalid email or password"
      render 'login/index'
    end
  end
end