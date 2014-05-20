
class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def self.all_except(user)
    where.not(id: user)
  end
end