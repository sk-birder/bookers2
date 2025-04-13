class BooksController < ApplicationController
  def create
    @post_book = Book.new(book_params)
    @post_book.user_id = current_user.id
    if @post_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@post_book.id)
    else
      @books = Book.all
      @user_info = current_user
      render :index
    end
  end
  
  def index
    @books = Book.all
    @post_book = Book.new
    @user_info = current_user
  end

  def show
    @show_book = Book.find(params[:id])
    @post_book = Book.new
    @user_info = User.find(@show_book.user_id)
  end

  def edit
    is_matching_login_user
  end

  def update
    is_matching_login_user
    if @show_book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @show_book = Book.find(params[:id])
    @show_book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @show_book = Book.find(params[:id])
    if @show_book.user_id != current_user.id
      redirect_to books_path
    end
  end

end
