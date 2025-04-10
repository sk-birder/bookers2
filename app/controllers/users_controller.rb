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
  end

  def show
    @post_book = Book.new
    @books = Book.all
  end

  def edit
  end

  private
  def post_book_params
    params.require(:book).permit(:image, :title, :body) # 実際には画像投稿は実装しない
  end

end
