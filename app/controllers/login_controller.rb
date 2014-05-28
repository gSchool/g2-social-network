class LoginController < ApplicationController
  def index
  end
  def confirmation
    @user = User.find params[:id]
  end
end