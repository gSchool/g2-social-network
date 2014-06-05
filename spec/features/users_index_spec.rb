require 'spec_helper'

feature "Users interact with site" do
  before :each do

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

    seth = User.create(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )

    bebe = User.create(
      first_name: 'Bebe',
      last_name: 'Peng',
      email: 'bebe@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )

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


  scenario "user can request to add a friend and that friend can confirm" do

    #confirmation link should send the user requestee to the all users page
    # user requestee should have been able to bypass the logging in process to arrive at all users page
    # page should display user requestor's name on list of all users
    # page should display 'Unfriend' next to user requestor's name

    seth = User.create(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )
    visit '/'
    click_on 'Login'
    fill_in 'Email', with: 'elli@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'

    expect(page).to_not have_content 'Unfriend'
    expect(ActionMailer::Base.deliveries.length).to eq 0

    within '.body_container' do
      page.first(:button, 'Add Friend').click
    end

    expect(page).to have_content 'Friendship request sent'
    expect(page).to have_content 'Pending'

    email_message = ActionMailer::Base.deliveries.last.body
    p email_message
    @doc = Nokogiri::HTML(email_message)
    result = @doc.xpath("//html//body//p//a//@href")[0].value

    expect(page).to have_content 'All Users'
    expect(page).to have_button('Unfriend')
    #expect(ActionMailer::Base.deliveries.length).to eq 1
    #
    #within(:xpath, '//li/user')).to eq true
    #puts page.xpath("//li[@class,'user']")

    #expect()

    #expect(page).to have_content 'A Reset email has been sent if email is valid.'
    #
    #found_user = User.find_by(email: "user@example.com")
    #expect(found_user.reset_token).to_not be_nil
    #
    #email_message = ActionMailer::Base.deliveries.last.body.raw_source
    #@doc = Nokogiri::HTML(email_message)
    #result = @doc.xpath("//html//body//p//a//@href")[0].value

  end

  scenario "user can remove a friend" do

    seth = User.create(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )

    visit '/'
    click_on 'Login'
    fill_in 'Email', with: 'elli@example.com'
    fill_in 'Password', with: 'hello12345'
    click_button 'Login'

    expect(page).to_not have_content 'Unfriend'

    graph = Graph.new
    graph.add_friendship(@ellie.id, seth.id)
    graph.confirm_friendship(@ellie.id, seth.id)

    visit page.current_path

    within '.body_container' do
      page.first(:button, 'Unfriend').click
    end
    expect(page).to have_content 'Friend removed'
    expect(page).to have_content 'Add Friend'
    expect(page).to_not have_content 'Unfriend'
  end

  scenario "user can see photos of all friends" do
    seth = User.create(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
      password: 'hello12345',
      password_confirmation: 'hello12345',
      confirmation: true
    )

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
end