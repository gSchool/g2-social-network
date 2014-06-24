require 'spec_helper'

feature "Users interact with site" do
  include ActiveSupport::Testing::TimeHelpers

  before do
    @ellie = create_user(
      first_name: 'Ellie',
      last_name: 'S',
      email: 'elli@example.com',
    )
  end

  scenario "user can view all users" do

    create_user(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
    )

    create_user(
      first_name: 'Bebe',
      last_name: 'Peng',
      email: 'bebe@example.com',
    )

    log_user_in(@ellie)

    expect(page).to have_content "Bebe Peng"
    expect(page).to have_content "Add Friend"
    expect(page).to have_content "Seth M"
    expect(page).to have_content "Add Friend"
  end

  scenario "only logged in users can view all users" do
    visit '/users'
    expect(page).to have_content "Please login"
  end


  scenario "user can request to add a friend and that friend can confirm" do
    ActionMailer::Base.deliveries.clear
    seth = create_user(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
    )

    log_user_in(@ellie)

    within('.non_friend_container') do
      expect(page).to have_content 'Seth M'
      expect(page).to have_content 'Add Friend'
    end

    expect(number_of_emails_received).to eq 0

    within '.non_friend_container' do
      page.first(:button, 'Add Friend').click
    end

    expect(number_of_emails_received).to eq 1

    expect(page).to have_content 'Friendship request sent'

    within('.non_friend_container') do
      expect(page).to have_content 'Seth M'
      expect(page).to have_content 'Pending'
    end

    click_on 'Logout'

    log_user_in(seth)
    visit "/confirm-friendships/#{seth.id}/#{@ellie.id}"

    within('.friend_container') do
      expect(page).to have_text('Ellie S')
      expect(page).to have_button('Unfriend')
    end

    click_on 'Logout'

    log_user_in(@ellie)
    within('.friend_container') do
      expect(page).to have_text('Seth M')
      expect(page).to have_button('Unfriend')
    end
  end

  scenario "user can remove a friend" do

    seth = create_user(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
    )

    graph = SocialGraph.new
    graph.add_friendship(@ellie.id, seth.id)
    graph.confirm_friendship(@ellie.id, seth.id)

    log_user_in(@ellie)

    within '.friend_container' do
      expect(page).to have_content 'Seth M'
      page.first(:button, 'Unfriend').click
    end
    expect(page).to have_content 'Friend removed'

    within '.non_friend_container' do
      expect(page).to have_content 'Seth M'
      expect(page).to have_content 'Add Friend'
    end

    within '.friend_container' do
      expect(page).to have_no_content 'Seth M'
    end
  end

  scenario "user can see photos of all friends" do
    seth = create_user(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
    )

    log_user_in(@ellie)

    click_link 'elli@example.com'
    attach_file('Profile pic', Rails.root.join('spec/images/unicorn_cat.jpg'))
    click_on 'Upload Picture'
    click_on 'Logout'

    log_user_in(seth)
    expect(page).to have_css('img', visible: 'unicorn_cat.jpg')
  end

  scenario 'a user can view their own posts and the posts of users they are friends with' do
    seth = create_user(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
    )

    bebe = create_user(
      first_name: 'Bebe',
      last_name: 'Peng',
      email: 'bebe@example.com',
    )

    graph = SocialGraph.new
    graph.add_friendship(seth.id, bebe.id)
    graph.confirm_friendship(seth.id, bebe.id)

    log_user_in(seth)

    click_on 'seth@example.com'
    fill_in 'post[post_body]', with: 'hello'
    click_on 'Post'
    click_on 'Logout'

    log_user_in(@ellie)

    click_on 'elli@example.com'
    fill_in 'post[post_body]', with: 'goodbye'
    click_on 'Post'
    click_on 'Logout'

    log_user_in(bebe)

    click_on 'bebe@example.com'
    fill_in 'post[post_body]', with: 'cya later'
    click_on 'Post'
    expect(page).to have_content 'hello'
    expect(page).to have_content 'cya later'
    expect(page).to_not have_content 'goodbye'
  end

  scenario 'user\'s session expires after 1 day' do
    log_user_in(@ellie)

    travel_to(1.day.from_now) do
      visit '/'
      expect(page).to have_content 'Login'
      expect(page).to_not have_content 'elli@example.com'
    end
  end
end
