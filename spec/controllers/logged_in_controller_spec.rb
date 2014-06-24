require 'spec_helper'

describe LoggedInController do

  controller UsersController do
    def index

    end
  end

  it "redirects to the home page if user is not logged in" do
    session[:id] = nil
    get :index
    expect(response).to redirect_to root_path
  end
end
