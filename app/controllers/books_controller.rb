class BooksController < ApplicationController

  def index
   @book = Book.new
   @books = Book.all
   @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if  @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to books_path
   else
    redirect_to books_path
   end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
   if book.update(book_params)
    flach[:notice] = "You have updated book successfully."
    redirect_to book_path(book.id)
   else
    redirect_to books_edit_path(book.id)
   end
  end

  def dastroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
