class UsersController < ApplicationController
  def create
    @post_book = Book.new(post_book_params)
    @post_book.user_id = current_user.id
    if @post_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(params[:id])
    else
    end
  end

  def new
  end

  def index
    @post_book = Book.new
    @users = User.all
    @user_info = current_user
  end

  def show
    @books = Book.where('user_id == ?', params[:id]) # プレースホルダを使った検索 SQLインジェクション対策に
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
    params.require(:user).permit(:user_image, :name, :introduction)
  end

  def post_book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to users_path
    end
  end
end
