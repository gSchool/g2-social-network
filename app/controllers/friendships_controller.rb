class FriendshipsController < ApplicationController
  def create
    friend_id = params[:friend_id]
    friend = User.find(friend_id)
    #we actually dont want it to add this yet
    success = SocialGraph.new(current_user).add_friendship(friend_id)
    if success
      ConfirmFriendMailer.friend_request_email(current_user, friend).deliver
      flash[:message] = "Friendship request sent"
    end
    redirect_to '/users'
  end

  def destroy
    friend_id = params[:id]
    success = SocialGraph.new(current_user).remove_friendship(friend_id)
    if success
      flash[:message] = "Friend removed"
    end
    redirect_to '/users'
  end
end