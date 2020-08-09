class SearchController < ApplicationController
    before_action :authenticate_user!
	  def search
	    @model = params[:search_model]
      method = params[:search_method]
      word = params[:search_word]
      @word = params[:search_word]
      if @model == "user"
        @posts = User.search(method,word)
  	  else
        @posts = Book.search(method,word)
      end
  	end
end
