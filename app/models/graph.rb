class Graph

  def add_friendship(user_id, friend_id)
    Friendship.create(user_id: user_id, friend_id: friend_id)
  end
end