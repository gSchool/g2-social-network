class UsersController < LoggedInController

  include ProfileMethods

  def index
    @users = User.all_except(session[:id])
    @current_user = current_user
    @graph = Graph.new
    @list_of_friends = @graph.friends_for(@current_user)
    @list_of_non_friends = @users - @list_of_friends
  end

  def show
    @post = Post.new
    user = User.find(params[:id])
    render_profile_page(user)
  end

  def update
    @user = current_user
    if params[:user]
      @user.profile_pic = params[:user][:profile_pic]
      @user.save
    else
      flash[:notice] = "You must select a file to upload!"
    end
    redirect_to user_path
  end

end