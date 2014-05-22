
class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, {presence: true, uniqueness: true }
  validates :password, length: {minimum: 8}

  def self.all_except(user_id)
    where.not(id: user_id)
  end
end