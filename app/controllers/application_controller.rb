class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    if session[:id]
      User.find(session[:id])
    end
  end
  helper_method :current_user

  def log_user_out
    session[:id] = nil
  end
  helper_method :log_user_out

  def log_user_in(user)
    session[:id] = user
  end
end