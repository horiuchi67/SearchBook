class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
  	  @user = User.find(params[:id])
  	  @books = Book.all
  end

  def index
  	  @users = User.page(params[:page]).reverse_order
  	  @books = Book.all
  end
  def edit
  	  @user = User.find(params[:id])
      unless @user.id == current_user.id
        redirect_to user_path(current_user)
      end
  end
  def update
  	  @user = User.find(params[:id])
      if @user.update(user_params)
      flash[:notice] = "ユーザー情報更新しました。"
      redirect_to user_path(@user.id)
      else
        render 'edit'
      end
  end

  def follows
      @user = User.find(params[:id])
      @users = @user.followings
  end

  def followers
      @user = User.find(params[:id])
      @users = @user.followers
  end


  private
  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
