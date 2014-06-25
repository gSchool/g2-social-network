class Message < ActiveRecord::Base
  validates :receiver, presence: true
end