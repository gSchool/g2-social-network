require 'spec_helper'

feature 'User can see their details on their profiles page' do
  scenario 'User can see their profile details and add a profile picture' do
    create_user(email: 'example@example.com', password: '12345678', confirmation: true)
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: '12345678'
    click_button 'Login'

    click_link 'example@example.com'
    expect(page).to have_content 'Gerard Cote'
    expect(page).to have_content 'example@example.com'

    click_link 'example@example.com'
    attach_file('Profile pic', Rails.root.join('spec/images/unicorn_cat.jpg'))
    click_on 'Upload Picture'
    page.should have_css('img', visible: 'unicorn_cat.jpg')
  end
end