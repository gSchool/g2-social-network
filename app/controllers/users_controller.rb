class UsersController < LoggedInController

  include ProfileMethods

  def index
    @users = User.all_except(session[:id])
    @current_user = current_user
    @list_of_friends = @current_user.friendships.map { |friend| User.find(friend[:friend_id])}
    @list_of_non_friends = @users.select { |user| !@list_of_friends.include? user }
  end

  def show
    @post = Post.new
    render_profile_page(params[:id])
  end

  def update
    @user = current_user
    @user.profile_pic = params[:user][:profile_pic]
    @user.save
    redirect_to user_path
  end

end