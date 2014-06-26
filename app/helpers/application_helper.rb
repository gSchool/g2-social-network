module ApplicationHelper

  def messages_json(messages)
    result = []
    messages.each do |message|
      hash = message.as_json
      hash[:sender_name] = full_name_of(message.sender_id)
      hash[:receiver_name] = full_name_of(message.receiver_id)
      hash[:sender_image_path] = image_path(UserHelper.small_thumb_pic(User.find(message.sender_id)), :class => "profile_pic")
      result << hash
    end
    result.to_json
  end

end
