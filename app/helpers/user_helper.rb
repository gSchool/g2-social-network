module UserHelper

  def self.profile_pic(user)
    if user.profile_pic?
      return user.profile_pic
    else
      return 'person_placeholder.png'
    end
  end

  def self.thumb_pic(user)
    if user.profile_pic?
      return user.profile_pic.thumb
    else
      return 'person_placeholder.png'
    end
  end
end
