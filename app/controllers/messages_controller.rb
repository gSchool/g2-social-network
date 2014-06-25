class MessagesController < ApplicationController
  def index
    @sent_messages = Message.where(:sender_id => current_user.id)
    @received_messages = Message.where(:receiver_id => current_user.id)
  end

  def new
    @message = Message.new
    @user = current_user
    @friends = SocialGraph.new(@user).friends_for
  end

  def create
    message = Message.new(:sender_id => current_user.id,
                          :receiver_id => params[:message][:receiver_id],
                          :subject => params[:message][:subject],
                          :body => params[:message][:body])
    if message.save
      redirect_to user_messages_path(current_user), notice: "Message successfully sent!"
    else
      redirect_to user_messages_path(current_user), notice: 'You must specify a friend to send a message to'
    end
  end

end