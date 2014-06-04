module ProfileMethods

  def render_profile_page(user_id)
    @user = User.find(user_id)
    @posts = Post.where(user_id: user_id).includes(:user)
    render 'users/show'
  end

end