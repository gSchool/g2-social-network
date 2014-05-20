class UsersController < ApplicationController
  def index
    if current_user
      @users = User.all_except(session[:id])
      @graph = Graph.new
      @current_user = current_user
    else
      render 'public/404.html'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
    first_name: params[:user][:first_name],
    last_name: params[:user][:last_name],
    email: params[:user][:email],
    password: params[:user][:password],
    password_confirmation: params[:user][:password_confirmation]
    )
    if @user.save
      log_user_in(@user.id)
      flash[:register_message] = "Welcome #{@user.email}"
      redirect_to '/users'
    else
      render 'users/new'
    end
  end
end