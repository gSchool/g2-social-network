class PostsController < LoggedInController

  include ProfileMethods

  def create
    @post = Post.new(post_params)
    user = User.find(params[:user_id])
    @post.user_id = params[:user_id]
    if @post.save
      redirect_to user_path(user)
    else
      render_profile_page(params[:user_id])
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_body)
  end
end