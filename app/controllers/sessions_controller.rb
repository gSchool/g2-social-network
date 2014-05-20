class SessionsController < ApplicationController
  def destroy
    log_user_out
    redirect_to root_path, notice: "You have been logged out"
  end
end