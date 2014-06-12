require 'spec_helper'

describe UserHelper do
  describe 'user profile picture to show' do
    context 'when user has a profile picture' do
      it 'returns the link to that picture' do
        user = new_user
        user.profile_pic = File.open(Rails.root.join('spec/images/unicorn_cat.jpg'))

        expect(UserHelper.profile_pic(user).identifier).to eq "unicorn_cat.jpg"
      end
    end
    context 'when user does not have a profile picture' do
      it 'returns the default profile picture' do
        user = new_user(profile_pic: nil)

        expect(UserHelper.profile_pic(user)).to eq "person_placeholder.png"
      end
    end
  end
end