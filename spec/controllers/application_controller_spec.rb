require 'spec_helper'

describe ApplicationController do
  # controller do
  #   def index
  #     raise ApplicationController::AccessDenied
  #   end
  # end

  describe 'current_user' do
    it 'returns nil if the user is not logged in' do
      expect(controller.current_user).to be_nil
    end
    it 'returns the user if there is a user logged in' do
      user = User.create!(first_name: 'Gerard',
                       last_name: 'Cote',
                       email: 'gerard@example.com',
                       password: 'hello123'
      )
      session[:id] = user.id

      expect(controller.current_user).to eq user
    end
  end

  describe "is_logged_in?" do
    it "returns false if the id is not set in the session" do
      expect(controller.is_logged_in?).to eq false
    end

    it "returns true if the id is set in the session" do
      session[:id] = 123
      expect(controller.is_logged_in?).to eq true
    end
  end
end