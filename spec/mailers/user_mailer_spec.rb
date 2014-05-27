require "spec_helper"

describe UserMailer do

  let(:user) { new_user(:email => 'gerardcote25@example.com') }
  let(:mail) { UserMailer.welcome_email(user) }

  it "email has the correct text" do
    email_text = mail.text_part.body.to_s
    expected = <<-INPUT.chomp
Welcome to example.com, Gerard
===============================================

You have successfully signed up to example.com,
your username is: gerardcote25@example.com.

To login to the site, just follow this link: /login.

Thanks for joining and have a great day!
    INPUT
    expect(email_text).to eq(expected)
  end

  it 'renders the subject' do
    expect(mail.subject).to eq("Welcome to Bradtke's Book!")
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(["confirmation@bradtkesbook.com"])
  end
end