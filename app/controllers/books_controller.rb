class BooksController < ApplicationController
  def create
    @post_book = Book.new(post_book_params)
    @post_book.user_id = current_user.id
    if @post_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@post_book.id)
    else
      @books = Book.all         # この行と
      @user_info = current_user # この行を一つにまとめたメソッドを作り、indexアクションと共有すること protectedならばuserコントローラでも使えるはず
      render :index
    end
  end
  
  def index
    @books = Book.all
    @post_book = Book.new
    @user_info = current_user
  end

  def show
    @post_book = Book.new
    @current_book = Book.find(params[:id])
    @user_info = User.find(@current_book.user_id)
  end

  def edit
    is_matching_login_user
  end

  def update
    is_matching_login_user
    if @current_book.update(post_book_params) # 機能はするが、変数の名前やストロングパラメータのメソッドの名前はこれでいいのだろうか…
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @current_book = Book.find(params[:id])
    @current_book.destroy
    redirect_to books_path
  end

  private
  def post_book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @current_book = Book.find(params[:id])
    if @current_book.user_id != current_user.id
      redirect_to books_path
    end
  end

end
