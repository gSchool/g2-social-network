require 'spec_helper'

describe ApplicationController do
  describe "current_user" do
    it "returns nil if a user is not logged in" do
      expect(controller.current_user).to be_nil
    end
    it "returns the user if user is logged in" do
      user = create_user
      controller.log_user_in(user.id)
      expect(controller.current_user).to eq user
    end

    it "can log a user in" do
      user = new_user(id: 1)
      controller.log_user_in(user.id)
      expect(session[:id]).to eq 1
    end

    it "can log a user out" do
      user = new_user(id: 1)
      controller.log_user_in(user.id)
      expect(session[:id]).to eq 1
      controller.log_user_out
      expect(session[:id]).to eq nil
    end
  end
end