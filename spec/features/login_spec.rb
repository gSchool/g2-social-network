require 'spec_helper'

feature 'User login' do

  before :each do
    visit ('/')
    click_on 'Register'
    fill_in 'First name', with: 'Bebe'
    fill_in 'Last name', with: 'Peng'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello12345'
    fill_in 'Confirm password', with: 'hello12345'

    click_on 'Create an Account'
    expect(page).to have_content "Welcome bebe@example.com"
    expect(page).to_not have_content "Register"
    expect(page).to_not have_content "Login"
  end

  scenario 'User can log in' do
    click_on 'Logout'
    click_on 'Login'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'
    expect(page).to have_content "Welcome back bebe@example.com"
  end

  scenario 'User can log out' do
    click_on "Logout"
    expect(page).to_not have_content "Logout"
    expect(page).to have_content "You have been logged out"
  end

  scenario 'User cannot login with invalid email' do
    click_on 'Logout'
    click_on 'Login'
    fill_in 'Email', with: 'bebe@test.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'
    expect(page).to have_content "Invalid email or password"
  end

  scenario 'User cannot login with valid email but invalid password' do
    click_on 'Logout'
    click_on 'Login'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello12'
    click_button 'Login'
    expect(page).to have_content "Invalid email or password"
  end

end