module NameHelper
  def user_display_name(user)
    "#{user.first_name} #{user.last_name} (#{link_to(user.email, user_path(user.id))})"
  end
end