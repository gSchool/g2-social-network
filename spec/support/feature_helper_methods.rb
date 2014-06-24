def log_user_in(user)
  visit '/'
  click_on 'Login'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Login'
end

def number_of_emails_received
  ActionMailer::Base.deliveries.length
end