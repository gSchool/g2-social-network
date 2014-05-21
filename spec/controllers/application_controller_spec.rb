require 'spec_helper'

describe ApplicationController do
  describe 'current_user' do
    it 'returns nil if the user is not logged in' do
      expect(controller.current_user).to be_nil
    end

    it 'returns a user if they are logged in' do
      user = User.create!(first_name: "Bob", last_name: "Smith", email: "bob@example.com", password: "password", password_confirmation: "password")

      controller.log_in(user)

      expect(controller.current_user).to eq user
    end
  end

  describe "is_logged_in?" do
    it "returns false if the is not logged in" do
      expect(controller.is_logged_in?).to eq false
    end

    it "returns true if the user is logged in" do
      user = User.create!(first_name: "Bob", last_name: "Smith", email: "bob@example.com", password: "password", password_confirmation: "password")

      controller.log_in(user)
      expect(controller.is_logged_in?).to eq true
    end
  end
end