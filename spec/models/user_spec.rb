require 'spec_helper'

describe User do
  describe "validations" do
    before do
      @user = new_user
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

    it "password can't be blank" do
      @user.password = ""
      @user.password_digest = ""
      expect(@user).to_not be_valid
    end

    it "password must be at least 10 characters" do
      @user.password = "123456789"
      expect(@user).to_not be_valid
      @user.password = "1234567890"
      expect(@user).to be_valid
    end

    it "removes a user by id from the user dataset" do
      user_1 = create_user
      user_2 = create_user
      expect(User.all_except(user_1.id)).not_to include(user_1)
      expect(User.all_except(user_1.id)).to include(user_2)
    end
  end
end