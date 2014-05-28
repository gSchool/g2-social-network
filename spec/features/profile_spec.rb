require 'spec_helper'

feature 'User can see their details on their profiles page ' do
  before do
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: '12345678'
    click_button 'Login'
  end

  scenario 'User can click on their email address after logged in and go to their profiles page' do
    click_link 'example@example.com'
    expect(page).to have_content 'Gerard Cote'
    expect(page).to have_content 'example@example.com'
  end

  scenario 'User can upload a profile picture' do
    click_link 'example@example.com'
    attach_file('Profile pic', Rails.root.join('spec/images/unicorn_cat.jpg'))
    click_on 'Upload Picture'
    page.should have_css('img', visible: 'unicorn_cat.jpg')
  end
end