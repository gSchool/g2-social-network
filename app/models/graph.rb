class Graph

  def add_friendship(user_id, friend_id)
    if user_id.to_i > 0 && friend_id.to_i > 0
      Friendship.create(user_id: user_id, friend_id: friend_id)
    else
      false
    end
  end

  def are_friends?(user1_id, user2_id)
    friendship = Friendship.where(
      "user_id = :user_id and friend_id = :friend_id OR user_id = :friend_id and friend_id = :user_id",
      user_id: user1_id,
      friend_id: user2_id
    )
    friendship.present?
  end
end