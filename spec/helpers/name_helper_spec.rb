require 'spec_helper'

describe NameHelper do
  describe '#user_display_name' do
    it 'displays the user first name, last name and email' do
      user = User.new(first_name: "Bob", last_name: "Smith", email: 'bob@example.com')

      expect(helper.user_display_name(user)).to eq "Bob Smith (bob@example.com)"
    end
  end

end