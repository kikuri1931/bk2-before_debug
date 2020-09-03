class FavoritesController < ApplicationController
	 before_action :authenticate_user!
	def create
	    book = Book.find(params[:book_id])
	    favorite = current_user.favorites.new(book_id: book.id)
	    favorite.save
	    redirect_back(fallback_location: books_path)
	end

	def destroy
	   book = Book.find(params[:book_id])
	   favorite = current_user.favorites.find_by(book_id: book.id)
	   if current_user.favorites.find_by(book_id: book.id) != nil
		   favorite.destroy
		   redirect_back(fallback_location: books_path)
		else
		   redirect_back(fallback_location: books_path)
		end
	end

end
