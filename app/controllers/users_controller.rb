class UsersController < LoggedInController

  include ProfileMethods

  def index
    @users = User.all_except(session[:id])
    @graph = Graph.new
    @current_user = current_user
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