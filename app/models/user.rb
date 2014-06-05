require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base
  mount_uploader :profile_pic, ProfilePictureUploader

  has_many :posts
  has_many :friendships

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, {presence: true, uniqueness: true }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password, length: {minimum: 8}, if: 'password.present?'

  def self.all_except(user_id)
    where.not(id: user_id)
  end

  def send_confirmation_email
    UserMailer.welcome_email(self).deliver
  end

  def confirm_user
    self.update_attributes(confirmation: true)
  end
end