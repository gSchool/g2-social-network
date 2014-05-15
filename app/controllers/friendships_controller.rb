class FriendshipsController < ApplicationController
  def create
    user_id = session[:id]
    friend_id = params[:friend_id]
    graph = Graph.new
    success = graph.add_friendship(user_id, friend_id)
    if success
      flash[:message] = "Friend added"
    end
    redirect_to '/users'
  end
end