module NameHelper
  def user_display_name(user)
    "#{h(user.first_name)} #{h(user.last_name)} (#{link_to(user.email, user_path(user.id))})".html_safe
  end
end