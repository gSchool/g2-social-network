require 'spec_helper'

describe NameHelper do
  describe '#user_display_name' do
    it 'displays the user first name, last name and email with a link to page' do
      user = User.new(id: 123, first_name: "Bob", last_name: "Smith", email: 'bob@example.com')

      expected = %q{Bob Smith (<a href="/users/123">bob@example.com</a>)}
      actual = helper.user_display_name(user)

      expect(actual).to eq expected
    end
  end

end