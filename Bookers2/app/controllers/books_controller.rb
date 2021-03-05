class BooksController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数に空のモデルオブジェクトを生成する。
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book.id)
    else
      @books = Book.all
      render action: :index
    end
  end

  def index
    @books = Book.all
    @book_new = Book.new

  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = User.find_by(id: @book.user_id)
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
    redirect_to book_path(@book.id)
    else
      render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
     flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
    end

  end



  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end