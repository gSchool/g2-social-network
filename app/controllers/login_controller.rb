class LoginController < ApplicationController
  def index
    @user = User.new
  end
end