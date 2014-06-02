class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.user_id = params[:user_id]
    @post.save!
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:post_body)
  end
end