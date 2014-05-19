class Graph

  def add_friendship(user_id, friend_id)
    if user_id.to_i > 0 && friend_id.to_i > 0
      Friendship.create(user_id: user_id, friend_id: friend_id)
    else
      false
    end
  end

  def are_friends?(user1_id, user2_id)
    Friendship.all.each do |friendship|
      if (friendship.user_id == user1_id && friendship.friend_id == user2_id) ||
        (friendship.user_id == user2_id && friendship.friend_id == user1_id)
        return true
      end
    end
    false
  end
end