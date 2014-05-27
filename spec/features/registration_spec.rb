require 'spec_helper'

feature 'User can create an account' do
  context "Successful registration" do
    scenario "User registers and is prompted to confirm their email" do
      visit ('/')
      click_on 'Register'
      fill_in 'First name', with: 'Bebe'
      fill_in 'Last name', with: 'Peng'
      fill_in 'Email', with: 'bebe@example.com'
      fill_in 'Password', with: 'hello12345'
      fill_in 'Confirm password', with: 'hello12345'

      click_on 'Create an Account'
      expect(page).to have_content "Please check your email for a confirmation"
      expect(page).to have_content "Register"
      expect(page).to have_content "Login"
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
      fill_in 'Confirm password', with: 'goodbye123'
      click_on 'Create an Account'
      expect(page).to have_content "Password must match confirmation"
    end
  end
end
