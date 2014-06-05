require 'spec_helper'

describe ConfirmFriendMailer do
  describe 'message when friendship request email is sent' do
    let(:requestor) { User.create!(:email => 'gerardcote25@example.com', :first_name => 'Gerard', :last_name => 'Cote', :password => 12341234) }
    let(:friend) { User.create!(:email => 'nate123@example.com', :first_name => 'Nate', :last_name => 'Burt', :password => 56785678) }
    let(:message) { ConfirmFriendMailer.friend_request_email(requestor, friend) }

    it 'comes from the friendships department at bradkes book' do
      expect(message.from).to eq ['friendships@bradtkesbook.com']
    end

    it 'goes to the person who is being friended' do
      expect(message.to).to eq ['nate123@example.com']
    end

    it 'has the correct subject' do
      expect(message.subject).to eq "You have received a friend request!"
    end

    it 'has the correct body' do
      email_text = message.text_part.body.to_s
      expected = <<INPUT.chomp
Hey, Nate!

You have a new friend request from Gerard Cote.

To confirm your friend request, just follow this link: <a href="http://localhost:3000/confirm-friendships/#{friend.id}/#{requestor.id}">Confirm Friendship</a>

Have a great day!
INPUT
      expect(email_text).to eq(expected)
    end

  end
end