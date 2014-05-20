require 'spec_helper'

describe ApplicationController do
  describe "current_user" do
    it "returns nil if a user is not logged in" do
      expect(controller.current_user).to be_nil
    end
    it "returns the user if user is logged in" do
      user = User.create!(
        first_name: 'Gerard',
        last_name: 'Cote',
        email: 'gerard@example.com',
        password: 'hello12345'
      )
      session[:id] = user.id
      expect(controller.current_user).to eq user
    end
  end
end