class SecureController < ApplicationController
  before_action :validate_session

  helper_method :logged_in?, :validate_session

  private

  def validate_session
    if logged_in?
      if session[:last_login] < 1.day.ago
        log_user_out
        redirect_to :root, notice: 'Your session has expired'
      end
    end
  end

  def logged_in?
    !!session[:id]
  end
end