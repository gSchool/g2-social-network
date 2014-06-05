class ConfirmFriendMailer < ActionMailer::Base
  default from: "friendships@bradtkesbook.com"

  def friend_request_email(requestor, friend)
    @requestor = requestor
    @friend = friend
    mail(to: @friend.email, subject: "You have received a friend request!")
  end
end