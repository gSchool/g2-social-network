class RegistrationsController < ApplicationController

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
      WelcomeEmailJob.new.async.perform(@user)
      redirect_to root_path, notice: "Please check your email for a confirmation"
    else
      render 'registrations/new'
    end
  end

end