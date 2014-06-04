class UsersController < ApplicationController

  include ProfileMethods

  before_action :is_user_logged_in?, except: [:send_confirmation_email, :confirm]

  def index
    @users = User.all_except(session[:id])
    @graph = Graph.new
    @current_user = current_user
  end

  def show
    @post = Post.new
    render_profile_page(params[:id])
  end

  def update
    @user = current_user
    @user.profile_pic = params[:user][:profile_pic]
    @user.save
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