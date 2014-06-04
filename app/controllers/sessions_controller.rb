class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      if user.confirmation
        log_user_in(user)
        flash[:login_message] = "Welcome back #{user.email}"
        redirect_to '/users'
      else
        redirect_to "/confirmations/confirmation/#{user.id}"
      end
    else
      flash[:failed_login] = "Invalid email or password"
      render 'sessions/new'
    end
  end

  def destroy
    log_user_out
    redirect_to root_path, notice: "You have been logged out"
  end

end