class SocialGraph

  def add_friendship(user_id, friend_id)
    if user_id.to_i > 0 && friend_id.to_i > 0
      Friendship.create(user_id: user_id, friend_id: friend_id, pending: true)
    else
      false
    end
  end

  def confirm_friendship(user_id, friend_id)
    friendship = find_friendship(user_id, friend_id)
    friendship.update(pending: false)
  end

  def friends_for(user)
    find_by_user_id = Friendship.where(user_id: user.id, pending: false).map { |friendship| User.find(friendship.friend_id) }
    find_by_friend_id = Friendship.where(friend_id: user.id, pending: false).map { |friendship| User.find(friendship.user_id) }
    find_by_user_id.concat(find_by_friend_id)
  end

  def are_friends?(user1_id, user2_id)
    friendship = find_friendship(user1_id, user2_id)
    friendship.present? && !friendship.pending?
  end

  def remove_friendship(user1_id, user2_id)
    find_friendship(user1_id, user2_id).destroy
  end

  def friendship_pending?(user1_id, user2_id)
    friendship = find_friendship(user1_id, user2_id)
    !!friendship && friendship.pending?
  end

  private

  def find_friendship(user1_id, user2_id)
    Friendship.where(
      "user_id = :user_id and friend_id = :friend_id OR user_id = :friend_id and friend_id = :user_id",
      user_id: user1_id,
      friend_id: user2_id
    ).first
  end
end
