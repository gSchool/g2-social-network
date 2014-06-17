feature 'private messaging' do
  scenario 'a user sends a message to a friend' do
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

    visit '/'
    click_on 'Login'
    fill_in 'Email', with: seth.email
    fill_in 'Password', with: seth.password
    click_button 'Login'

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
end