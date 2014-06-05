require "spec_helper"

describe UserMailer do

  let(:user) { create_user(:email => 'gerardcote25@example.com') }
  let(:mail) { UserMailer.welcome_email(user) }

  it "email has the correct text" do
    email_text = mail.text_part.body.to_s
    expected = <<-INPUT.chomp
Welcome to example.com, Gerard
===============================================

You have successfully signed up for Bradtke's Book,
your username is: gerardcote25@example.com.

To confirm your email address, just follow this link: <a href=\"http://localhost:3000/confirm/#{user.id}\">Confirm email address</a>.

Thanks for joining and have a great day!
    INPUT
    expect(email_text).to eq(expected)
  end

  it 'renders the subject' do
    expect(mail.subject).to eq("Welcome to Bradtke's Book!")
  end

  it 'renders the receiver email in the TO field' do
    expect(mail.to).to eq([user.email])
  end

  it 'renders the sender email in the FROM field' do
    expect(mail.from).to eq(["confirmation@bradtkesbook.com"])
  end
end