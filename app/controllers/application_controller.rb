class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :log_user_out, :log_user_in, :full_name_of

  def current_user
    if session[:id]
      User.find(session[:id])
    end
  end

  def log_user_out
    session[:id] = nil
  end

  def log_user_in(user)
    session[:id] = user.id
  end

  def full_name_of(user_id)
    User.find(user_id).full_name
  end
end