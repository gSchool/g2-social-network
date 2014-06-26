class LoggedInController < SecureController

  before_action :is_user_logged_in?

  private

  def is_user_logged_in?
    unless current_user
      redirect_to root_path, notice: "Please login"
    end
  end
end