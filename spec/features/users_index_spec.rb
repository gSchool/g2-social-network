require 'spec_helper'

feature "Users interact with site" do
  scenario "user can view all users" do
    visit '/'
    click_on 'Register'
    fill_in 'First name', with: 'Bebe'
    fill_in 'Last name', with: 'Peng'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'hello123'
    click_on 'Create an Account'

    visit '/'
    click_on 'Register'
    fill_in 'First name', with: 'Seth'
    fill_in 'Last name', with: 'M'
    fill_in 'Email', with: 'seth@example.com'
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'hello123'
    click_on 'Create an Account'

    visit '/'
    click_on 'Register'
    fill_in 'First name', with: 'Ellie'
    fill_in 'Last name', with: 'S'
    fill_in 'Email', with: 'elli@example.com'
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'hello123'
    click_on 'Create an Account'

    expect(page).to have_content "Bebe Peng"
    expect(page).to have_content "Seth M"
  end

  scenario "user can add a friend" do
    visit '/'
    click_on 'Register'
    fill_in 'First name', with: 'Bebe'
    fill_in 'Last name', with: 'Peng'
    fill_in 'Email', with: 'bebe@example.com'
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'hello123'
    click_on 'Create an Account'

    visit '/'
    click_on 'Register'
    fill_in 'First name', with: 'Seth'
    fill_in 'Last name', with: 'M'
    fill_in 'Email', with: 'seth@example.com'
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'hello123'
    click_on 'Create an Account'
    expect(page).to_not have_content 'Unfriend'

    within '#users_list_container' do
      page.first(:button, 'Add Friend').click
    end

    expect(page).to have_content 'Friend added'
    expect(page).to have_content 'Unfriend'
  end
end
