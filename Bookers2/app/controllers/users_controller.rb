class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render action: :show
    end
  end

  def index
    @users = User.all
    @user = current_user
    @books = @user.books
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    render action: :edit
    else
    @user = current_user
    @books = @user.books
    @book = Book.new
    redirect_to user_path(@user.id)
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end