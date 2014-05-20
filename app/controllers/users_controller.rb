class UsersController < ApplicationController
  def index
    @users = User.all
    @current_user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      session[:id] = @user.id
      redirect_to '/users'
    else
      render 'users/new'
    end
  end
end