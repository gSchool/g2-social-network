require 'spec_helper'

feature "Users interact with site" do
  before :each do
    @bebe = User.create(
      first_name: 'Bebe',
      last_name: 'Peng',
      email: 'bebe@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )
    @seth = User.create(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )
    @ellie = User.create(
      first_name: 'Ellie',
      last_name: 'S',
      email: 'elli@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )
  end

  scenario "user can view all users" do
    visit '/'
    click_on 'Login'
    fill_in 'Email', with: 'elli@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'

    expect(page).to have_content "Bebe Peng"
    expect(page).to have_content "Seth M"
  end

  scenario "only logged in users can view all users" do
    visit '/users'
    expect(page).to have_content "Please login"
  end


  scenario "user can add a friend" do
    visit '/'
    click_on 'Login'
    fill_in 'Email', with: 'seth@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'

    expect(page).to_not have_content 'Unfriend'

    within '.body_container' do
      page.first(:button, 'Add Friend').click
    end

    expect(page).to have_content 'Friend added'
    expect(page).to have_content 'Unfriend'
  end

  scenario "user can remove a friend" do
    visit '/'
    click_on 'Login'
    fill_in 'Email', with: 'seth@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'

    expect(page).to_not have_content 'Unfriend'

    within '.body_container' do
      page.first(:button, 'Add Friend').click
    end
    within '.body_container' do
      page.first(:button, 'Unfriend').click
    end
    expect(page).to have_content 'Friend removed'
    expect(page).to have_content 'Add Friend'
    expect(page).to_not have_content 'Unfriend'
  end

  scenario "user can see photos of all friends" do
    visit '/'
    click_on 'Login'
    fill_in 'Email', with: 'elli@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'
    click_link 'elli@example.com'
    attach_file('Profile pic', Rails.root.join('spec/images/unicorn_cat.jpg'))
    click_on 'Upload Picture'
    click_on 'Logout'
    click_on 'Login'
    fill_in 'Email', with: 'seth@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'
    expect(page).to have_css('img', visible: 'unicorn_cat.jpg')
  end

  scenario 'User can see friends in the left hand column and users their not friends with on the right' do
    visit '/'
    click_on 'Login'
    fill_in 'Email', with: 'seth@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'

    graph = Graph.new
    graph.add_friendship(@seth.id, @bebe.id)

    visit page.current_path

    within '.friend_container' do
      expect(page).to have_content('Bebe Peng')
    end

    within '.non_friend_container' do
      expect(page).to have_content('Ellie S')
    end

  end
end