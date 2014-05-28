require 'spec_helper'

describe User do
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

  it "email must be unique" do
    @user.save
    user_1 = new_user(:email => 'gerardcote@example.com')
    user_1.save
    expect(user_1).to_not be_valid
  end

  it "email must follow a certain format" do
    user_1 = new_user(:email => 'eric@')
    expect(user_1).to_not be_valid
  end

  it "password can't be blank" do
    @user.password = ""
    @user.password_digest = ""
    expect(@user).to_not be_valid
  end

  it "password must be at least 8 characters" do
    @user.password = "1234567"
    expect(@user).to_not be_valid
    @user.password = "12345678"
    expect(@user).to be_valid
  end

  it 'only validates length if password is present' do
    user = create_user
    @user = User.find(user.id)
    # This is an issue with has_secure_password not reloading password
    # virtual attribute when object is loaded.do
    # This causes problems later when I want to update a user attribute
    # without having their password
    expect(@user.password).to be_nil
    expect(@user).to be_valid
  end

  it "removes a user by id from the user dataset" do
    user_1 = create_user(email: 'ellie@example.com')
    user_2 = create_user(email: 'seth@example.com')
    expect(User.all_except(user_1.id)).not_to include(user_1)
    expect(User.all_except(user_1.id)).to include(user_2)
  end

  it "sends an email when a new user registers" do
    user = create_user(:email => 'gerardcote24@example.com')
    expect { UserMailer.welcome_email(user).deliver }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it "allows a user to be confirmed" do
    user = create_user(email: 'ellieee@example.com')
    expect(user.confirmation).to eq(false)
    user.confirm_user
    expect(user.confirmation).to eq(true)
  end
end