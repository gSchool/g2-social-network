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
    password_confirmation: 'hello12345'
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