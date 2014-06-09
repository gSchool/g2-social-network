module ProfileMethods

  def render_profile_page(user)
    @user = user
    @posts = Post.where(user_id: user.id).includes(:user)
    render 'users/show'
  end

end