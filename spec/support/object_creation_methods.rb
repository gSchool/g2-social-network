def create_user(attributes = {})
  user = new_user(attributes)
  user.save!
  user
end

def new_user(attributes= {})
  defaults = {
    first_name: 'Gerard',
    last_name: 'Cote',
    email: 'gerardcote@example.com',
    password: 'hello12345'
  }
  User.new(defaults.merge(attributes))
end