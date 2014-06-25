class MessagesController < ApplicationController
  def index
    @sent_messages = Message.where(:sender => current_user.id)
    @received_messages = Message.where(:receiver => current_user.id)
  end

  def new
    @message = Message.new
    @user = current_user
    @friends = SocialGraph.new(@user).friends_for
  end

  def create
    Message.create!(:sender => current_user.id,
                    :receiver => params[:message][:receiver],
                    :subject => params[:message][:subject],
                    :body => params[:message][:body])
    redirect_to user_messages_path(current_user), notice: "Message successfully sent!"
  end

end