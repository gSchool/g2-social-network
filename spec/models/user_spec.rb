require 'spec_helper'

describe User do
  describe "validations" do
    before do
      @user = User.new(first_name: 'Gerard',
                       last_name: 'Cote',
                       email: 'gerard@example.com',
                       password: 'hello12345'
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

    it "password can't be blank" do
      @user.password = ""
      @user.password_digest = ""
      expect(@user).to_not be_valid
    end

    it "password must be at least 10 characters" do
      @user.password = "123456789"
      expect(@user).to_not be_valid
    end

    it "removes a user by id from the user dataset" do
      user_2 = User.create!(first_name: 'Paul',
                   last_name: 'Wenig',
                   email: 'paul@example.com',
                   password: 'hello12345')

      user_3 = User.create!(first_name: 'Mike',
                   last_name: 'Kauffman',
                   email: 'mike@example.com',
                   password: 'hello12345')

      expect(User.all_except(user_2.id)).not_to include(user_2)
      expect(User.all_except(user_2.id)).to include(user_3)
    end
  end
end