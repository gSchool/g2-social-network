class FriendshipsController < ApplicationController
  def create
    user_id = current_user.id
    friend_id = params[:friend_id]
    friend = User.find(friend_id)
    #we actually dont want it to add this yet
    success = Graph.new.add_friendship(user_id, friend_id)
    if success
      ConfirmFriendMailer.friend_request_email(current_user, friend).deliver
      flash[:message] = "Friendship request sent"
    end
    redirect_to '/users'
  end

  def destroy
    user_id = current_user.id
    friend_id = params[:id]
    success = Graph.new.remove_friendship(user_id, friend_id)
    if success
      flash[:message] = "Friend removed"
    end
    redirect_to '/users'
  end
end