class UsersController < ApplicationController
  def create
    @post_book = Book.new(post_book_params)
    @post_book.user_id = current_user.id
    @post_book.save
    redirect_to book_path(params[:id])
  end

  def new
  end

  def index
    @post_book = Book.new
    @users = User.all
  end

  def show
    @books = Book.all # whereメソッドに変えるかも
    # @books = Book.where(user_id: user_id) # whereメソッドにhashでの指定
    @post_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user= User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:image, :name, :introduction)
  end

  def post_book_params
    params.require(:book).permit(:title, :body)
  end

end
