class SocialGraph

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def add_friendship(friend_id)
    if current_user.id > 0 && friend_id.to_i > 0
      Friendship.create(user_id: current_user.id, friend_id: friend_id, pending: true)
    else
      false
    end
  end

  def confirm_friendship(friend_id)
    friendship = find_friendship(friend_id)
    friendship.update(pending: false)
  end

  def friends_for
    find_by_user_id = Friendship.where(user_id: current_user.id, pending: false).map { |friendship| User.find(friendship.friend_id) }
    find_by_friend_id = Friendship.where(friend_id: current_user.id, pending: false).map { |friendship| User.find(friendship.user_id) }
    find_by_user_id.concat(find_by_friend_id)
  end

  def are_friends?(friend_id)
    friendship = find_friendship(friend_id)
    friendship.present? && !friendship.pending?
  end

  def remove_friendship(friend_id)
    find_friendship(friend_id).destroy
  end

  def friendship_pending?(friend_id)
    friendship = find_friendship(friend_id)
    !!friendship && friendship.pending?
  end

  private

  def find_friendship(friend_id)
    Friendship.where(
      "user_id = :user_id and friend_id = :friend_id OR user_id = :friend_id and friend_id = :user_id",
      user_id: current_user.id,
      friend_id: friend_id
    ).first
  end
end
