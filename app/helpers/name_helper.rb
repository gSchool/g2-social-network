module NameHelper
  def user_display_name(user)
    "#{user.first_name} #{user.last_name} (#{user.email})"
  end
end