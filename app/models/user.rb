require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: {message: "cannot be blank"}
  validates :last_name, presence: {message: "cannot be blank"}

end