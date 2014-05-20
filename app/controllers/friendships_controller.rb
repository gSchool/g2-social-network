class FriendshipsController < ApplicationController
  def create
    user_id = current_user.id
    friend_id = params[:friend_id]
    success = Graph.new.add_friendship(user_id, friend_id)
    if success
      flash[:message] = "Friend added"
    end
    redirect_to '/users'
  end
end