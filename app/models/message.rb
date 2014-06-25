class Message < ActiveRecord::Base
  validates :receiver_id, presence: true
end