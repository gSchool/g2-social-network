require 'spec_helper'

feature 'User can see their details on their profiles page' do
  scenario 'User can click on their email address and go to their profiles page' do
    create_user(email: 'example@example.com', password: '12345678')
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: '12345678'
    click_button'Login'
    
    click_link 'example@example.com'
    expect(page).to have_content 'Gerard Cote'
    expect(page).to have_content 'example@example.com'
  end
end