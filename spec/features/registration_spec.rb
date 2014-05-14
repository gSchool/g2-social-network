require 'spec_helper'

feature 'User can create an account' do
  scenario 'User can create a login and password' do
    visit ('/')
    expect(page).to have_content "Bradtke Book"
  end
end