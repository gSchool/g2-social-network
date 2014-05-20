class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :is_logged_in?

  def log_in(user)
    session[:id] = user.id
  end

  def current_user
    if is_logged_in?
      User.find(logged_in_user_id)
    end
  end

  def is_logged_in?
    !logged_in_user_id.nil?
  end

  def logged_in_user_id
    session[:id]
  end
end
