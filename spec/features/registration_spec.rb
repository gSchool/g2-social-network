require 'spec_helper'

feature 'User can create an account' do
  context "Successful registration" do

    before :each do
      visit ('/')
      click_on 'Register'
      fill_in 'First name', with: 'Bebe'
      fill_in 'Last name', with: 'Peng'
      fill_in 'Email', with: 'bebe@example.com'
      fill_in 'Password', with: 'hello12345'
      fill_in 'Password confirmation', with: 'hello12345'
      click_on 'Create an Account'
      expect(page).to have_content "Welcome bebe@example.com"
      expect(page).to_not have_content "Register"
      expect(page).to_not have_content "Login"
    end
    scenario 'User can log out' do
      click_on "Logout"
      expect(page).to_not have_content "Logout"
      expect(page).to have_content "You have been logged out"
    end
  end

  context "Registration validation" do
    scenario 'user tries to register with mis-matched passwords' do
      visit ('/')
      click_on 'Register'
      fill_in 'First name', with: 'Bebe'
      fill_in 'Last name', with: 'Peng'
      fill_in 'Email', with: 'bebe@example.com'
      fill_in 'Password', with: 'hello12345'
      fill_in 'Password confirmation', with: 'goodbye123'
      click_on 'Create an Account'
      expect(page).to have_content "Password must match confirmation"
    end
  end

end
