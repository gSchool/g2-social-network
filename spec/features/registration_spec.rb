require 'spec_helper'

feature 'User can create an account' do
  scenario 'User can create a login and password' do
    visit ('/')
    click_on 'Register'
    fill_in 'First name', with: 'Bebe'
    fill_in 'Last name', with: 'Peng'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'hello123'
    click_on 'Create an Account'
    expect(page).to have_content "Welcome bebe@example.com"
  end

  scenario 'user tries to register with mis-matched passwords' do
    visit ('/')
    click_on 'Register'
    fill_in 'First name', with: 'Bebe'
    fill_in 'Last name', with: 'Peng'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'goodbye123'
    click_on 'Create an Account'
    expect(page).to have_content "Password must match confirmation"
  end

end
