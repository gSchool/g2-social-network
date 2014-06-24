class Post < ActiveRecord::Base

  validates :post_body, :presence => true

  belongs_to :user

  def self.posts_for(user)
    social_graph = SocialGraph.new(user)
    friends = social_graph.friends_for
    user_posts = Post.where(user_id: user.id)
    friend_posts = Post.where(user_id: friends.map { |friend| friend.id })
    user_posts.concat(friend_posts)
  end

end