require 'spec_helper'

feature 'User login' do
  include ActiveSupport::Testing::TimeHelpers

  before :each do
    @bebe = create_user(
      first_name: 'Bebe',
      last_name: 'Peng',
      email: 'bebe@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )
    visit ('/')
  end

  scenario 'User can log in' do
    log_user_in(@bebe)
    expect(page).to have_content "Welcome back bebe@example.com"
  end

  scenario 'User can log out' do
    log_user_in(@bebe)
    click_on "Logout"
    expect(page).to_not have_content "Logout"
    expect(page).to have_content "You have been logged out"
  end

  scenario 'User cannot login with invalid email' do
    click_on 'Login'
    fill_in 'Email', with: 'bebe@test.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'
    expect(page).to have_content "Invalid email or password"
  end

  scenario 'User cannot login with valid email but invalid password' do
    click_on 'Login'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello12'
    click_button 'Login'
    expect(page).to have_content "Invalid email or password"
  end

  scenario "user's session expires after 1 day" do
    log_user_in(@bebe)

    travel_to(1.day.from_now) do
      visit '/'

      expect(current_path).to eq '/'
      expect(page).to have_content 'Your session has expired'
      expect(page).to have_content 'Login'
      expect(page).to_not have_content 'bebe@example.com'

    end

    log_user_in(@bebe)

    travel_to(1.day.from_now) do
      visit '/users'

      expect(current_path).to eq '/'
      expect(page).to have_content 'Your session has expired'
      expect(page).to have_content 'Login'
      expect(page).to_not have_content 'bebe@example.com'
    end
  end

end