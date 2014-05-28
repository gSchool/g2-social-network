class UsersController < ApplicationController
  before_action :is_user_logged_in?, only: [:index]

  def index
    @users = User.all_except(session[:id])
    @graph = Graph.new
    @current_user = current_user
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
      UserMailer.welcome_email(@user).deliver
      redirect_to root_path, notice: "Please check your email for a confirmation"
    else
      render 'users/new'
    end
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.profile_pic = params[:user][:profile_pic]
    @user.save!
    redirect_to user_path
  end

  def confirm
    user = User.find params[:id]
    user.confirm_user
    redirect_to '/login', notice: "Your email has been confirmed. You can now log in"
  end

  def send_confirmation_email
    user = User.find params[:id]
    UserMailer.welcome_email(user).deliver
    redirect_to root_path, notice: "Email has been sent to #{user.email}. Please check your email to confirm"
  end

  private

  def is_user_logged_in?
    unless current_user
      redirect_to root_path, notice: "Please login"
    end
  end
end