class UsersController < ApplicationController
  def index
    if session[:id] != nil
      @users = User.all
      @current_user = User.find session[:id]
    else
      render 'public/404.html'
    end
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
      flash[:register_message] = "Welcome #{@user.email}"
      redirect_to '/users'
    else
      render 'users/new'
    end
  end
end