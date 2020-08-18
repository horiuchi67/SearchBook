class BooksController < ApplicationController
    before_action :authenticate_user!
    def top
    end
    def new
      @book = Book.new
    end
    def create
  	  @book = Book.new(book_params)
  	  @book.user_id = current_user.id
  	  if @book.save
      flash[:notice] = "新規投稿しました。"
  	  redirect_to book_path(@book.id)
    else
      @book = Book.new
      flash[:notice] = "新規投稿できませんでした。"
      render 'new'
      end
    end
    def index
  	  @books = Book.page(params[:page]).reverse_order
    end
    def show
  	  @book = Book.find(params[:id])
      @user = @book.user
      @book_comment = BookComment.new
    end
    def destroy
      @book = Book.find(params[:id])
      @book.destroy
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
        flash[:notice] = "編集完了しました。"
        redirect_to book_path(@book.id)
      else
        render 'edit'
      end
    end
		def book_params
  	  	params.require(:book).permit(:title, :author, :body)
		end

end
