class Post < ActiveRecord::Base

  validates :post_body, :presence => true

  belongs_to :user

end