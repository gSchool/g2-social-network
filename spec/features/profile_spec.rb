require 'spec_helper'

feature 'User can see their details on their profiles page' do

  before do
    create_user(email: 'example@example.com', password: '12345678', confirmation: true)
    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: '12345678'
    click_button 'Login'
  end

  scenario 'User can see their profile details and add a profile picture' do
    click_link 'example@example.com'
    expect(page).to have_content 'Gerard Cote'
    expect(page).to have_content 'example@example.com'

    click_link 'example@example.com'
    attach_file('Profile pic', Rails.root.join('spec/images/unicorn_cat.jpg'))
    click_on 'Upload Picture'
    expect(page).to have_css('img', visible: 'unicorn_cat.jpg')
  end

  scenario 'User can click on link in nav to see all users' do
    click_on 'All Users'
    expect(page).to have_content 'All Users'
  end

  scenario 'User can post on their wall' do
    create_user(first_name: 'Nate',
                last_name: 'Burt',
                email: 'nate@example.com',
                password: 'hello12345',
                confirmation: true)

    click_on 'example@example.com'
    fill_in 'post[post_body]', with: 'This is my first post!'
    click_on 'Post'
    click_link 'Logout'

    click_link 'Login'
    fill_in 'Email', with: 'nate@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'

    click_link 'nate@example.com'
    fill_in 'post[post_body]', with: "This is Nate's post!"
    click_on 'Post'

    expect(page).to have_content "This is Nate's post"
    expect(page).to_not have_content('Gerard wrote: This is my first post!')
  end
end
