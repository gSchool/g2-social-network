class UsersController < ApplicationController
  def index
    if session[:id] != nil
      @users = User.all_except(session[:id])
      @graph = Graph.new
      @current_user = User.find session[:id]
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

      session[:id] = @user.id
      flash[:register_message] = "Welcome #{@user.email}"
      redirect_to '/users'
    else
      render 'users/new'
    end
  end
end