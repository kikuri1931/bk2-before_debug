class SearchController < ApplicationController
	before_action :authenticate_user!
	def search
		@range = params[:range]
		search = params[:search]
		word = params[:word]

		if @range == '1'
			@users = User.search(search,word)
		else
			@books = Book.search(search,word)
		end
	end
end
