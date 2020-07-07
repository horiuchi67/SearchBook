class FavoritesController < ApplicationController
	def create
		@book1 = Book.find(params[:book_id])
		favorite = current_user.favorites.build(book_id: @book1.id)
		favorite.save
	end
	def destroy
		@book1 = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: @book1.id)
		favorite.destroy
	end
end
