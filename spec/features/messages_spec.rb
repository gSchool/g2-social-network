require 'spec_helper'

feature 'private messaging' do
  scenario 'a user sends a message to a friend', js: true do
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

    create_friendship(seth, bebe)

    log_user_in(seth)

    click_on 'messages'
    click_on 'Send a Message'

    fill_in 'Subject', with: 'Hello!'
    fill_in 'Message', with: 'How are you?'
    select "#{bebe.first_name} #{bebe.last_name}"
    click_button 'Send'

    expect(page).to have_content 'Message successfully sent!'
    expect(page).to have_content 'Sent Messages'
    expect(page).to have_content "To: #{bebe.first_name} #{bebe.last_name}"
    expect(page).to have_content 'Subject: Hello!'
  end

  scenario 'a user can see the messages they receive', js: true do
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

    create_friendship(seth, bebe)

    log_user_in(seth)

    click_on 'messages'
    click_on 'Send a Message'

    select "#{bebe.first_name} #{bebe.last_name}"
    fill_in 'Subject', with: 'Hello!'
    fill_in 'Message', with: 'How are you?'
    click_button 'Send'

    expect(page).to have_content 'Message successfully sent!'

    click_link 'Logout'

    log_user_in(bebe)

    click_on 'messages'

    expect(page).to have_content 'Received Messages'
    expect(page).to have_css("img[src*='small_placeholder']")
    expect(page).to have_content "From: #{seth.first_name} #{seth.last_name}"
    expect(page).to have_content 'Subject: Hello!'

    expect(page).to_not have_content 'How are you?'

    click_link 'show-body'

    within 'div#message-body' do
      expect(page).to have_content 'How are you?'
    end
  end

  scenario 'a user must specify a friend to send a message to', js: true do
    seth = create_user(
      first_name: 'Seth',
      last_name: 'M',
      email: 'seth@example.com',
    )

    log_user_in(seth)

    click_on 'messages'
    click_on 'Send a Message'

    fill_in 'Subject', with: 'Hello!'
    fill_in 'Message', with: 'How are you?'
    click_button 'Send'

    expect(page).to have_content 'You must specify a friend to send a message to'
    expect(page).to have_content 'Sent Messages'
  end
end