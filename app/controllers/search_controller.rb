class SearchController < ApplicationController
	def search
		@range = params[:range]
		search = params[:search]
		word = params[:word]

		if @range == '1'
			@user = User.search(search,word)
			render 'search/user_search'
		else
			@book = Book.search(search,word)
			render 'search/book_search'
		end
	end
end
