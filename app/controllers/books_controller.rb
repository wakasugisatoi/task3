class BooksController < ApplicationController
  
  def index
    @book = Book.new
    @book.user_id = current_user.id
    @books = Book.all
    @user = @book.user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = @book.user
   if  @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
   else 
     flash.now[:notice] = "You haven't created book successfully."   
     render :index
   end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end
  
  def edit 
    @book = Book.find(params[:id])
    user = @book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to book_path(@book.id)  
    else 
      flash.now[:notice] = "You haven't updated book successfully."     
      render :edit
    end 
  end

  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)  
  end
  
end
