class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @book = Book.new
    @booking = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @booking = Book.find(params[:id])
    if @booking.user == current_user
      render 'edit'
    else 
      redirect_to books_path
    end
  end



  def update
    @booking = Book.find(params[:id])
    if @booking.update(book_params)
      redirect_to book_path(@booking), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @booking = Book.find(params[:id])
    @booking.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
