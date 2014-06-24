module ProfileMethods

  def render_profile_page(user)
    @user = user
    @posts = Post.posts_for(user)

    render 'users/show'
  end
end