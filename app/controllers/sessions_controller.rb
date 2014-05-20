class SessionsController < ApplicationController
  def destroy
    session[:id] = nil
    redirect_to root_path
  end
end