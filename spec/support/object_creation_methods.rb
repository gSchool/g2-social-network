def create_user(attributes = {})
  user = new_user(attributes)
  user.save!
  user
end

def new_user(attributes = {})
  defaults = {
    first_name: 'Gerard',
    last_name: 'Cote',
    email: 'gerardcote@example.com',
    password: 'hello12345',
    confirmation: true
  }
  User.new(defaults.merge(attributes))
end

def create_post(user_id, attributes = {})
  user = new_post(user_id, attributes)
  user.save!
  user
end

def new_post(user_id, attributes = {})
  defaults = {
    user_id: user_id,
    post_body: 'post body',
  }
  Post.new(defaults.merge(attributes))
end

def create_friendship(user1, user2)
  Friendship.create(user_id: user1.id, friend_id: user2.id, pending: false)
end