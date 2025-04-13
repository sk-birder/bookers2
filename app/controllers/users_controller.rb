class UsersController < ApplicationController
  def index
    @users = User.all
    @post_book = Book.new
    @user_info = current_user
  end

  def show
    @books = Book.where('user_id == ?', params[:id]) # プレースホルダを使った検索 ここでは無関係だがSQLインジェクション対策になるようだ
    @post_book = Book.new
    @user_info = User.find(params[:id])
  end

  def edit
    is_matching_login_user
  end

  def update
    is_matching_login_user
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
