require 'spec_helper'

describe User do
  describe "validations" do
    before do
      @user = User.new(first_name: 'Gerard',
                       last_name: 'Cote',
                       email: 'gerard@example.com',
                       password: 'hello123'
      )
      expect(@user).to be_valid
    end

    it "first name can't be blank" do
      @user.first_name = " "
      expect(@user).to_not be_valid
    end

    it "last name can't be blank" do
      @user.last_name = " "
      expect(@user).to_not be_valid
    end

    it "email can't be blank" do
      @user.email = " "
      expect(@user).to_not be_valid
    end
  end
end