class BooksController < ApplicationController
    before_action :authenticate_user!
    def top
    end
    def create
  	  @book = Book.new(book_params)
  	  @book.user_id = current_user.id
  	  if @book.save
      flash[:notice] = "You have creatad book successfully."
  	  redirect_to book_path(@book.id)
      else

        @books = Book.all
        render 'index'

      end
    end
    def index
  	  @book = Book.new
  	  @books = Book.all
    end
    def show
    	@book = Book.new
  	  @book1 = Book.find(params[:id])
      @user = @book1.user
    end
    def destroy
    @book1 = Book.find(params[:id])
    @book1.destroy
    redirect_to books_path
end
 def edit
      @book = Book.find(params[:id])
      unless @book.user_id == current_user.id
        redirect_to books_path
      end

  end

  def update
      @book = Book.find(params[:id])

      if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
      else
        render 'edit'

      end
  end
		def book_params
  	  	params.require(:book).permit(:title, :body)
		end

end
