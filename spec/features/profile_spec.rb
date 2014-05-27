require 'spec_helper'

feature 'User can see their details on their profiles page' do
  scenario 'User can click on their email address and go to their profiles page' do
    visit root_path
    click_on 'Register'
    fill_in 'First name', with: 'Bebe'
    fill_in 'Last name', with: 'Peng'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello12345'
    fill_in 'Confirm password', with: 'hello12345'
    click_on 'Create an Account'
    
    click_link 'bebe@example.com'
    expect(page).to have_content 'Bebe Peng'
    expect(page).to have_content 'bebe@example.com'
  end
end