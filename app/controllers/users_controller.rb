class UsersController < ApplicationController
    
    def show 
      @user = User.find(params[:id])
      @book = Book.new
      @books = @user.books
    end
    
  
    def index
      @user = current_user   
      @users = User.all
      @book = Book.new
      @books = @user.books
    end
    
    def edit
      @user = User.find(params[:id])
      unless @user.id == current_user.id
        redirect_to user_path(current_user.id)
      end
    end 
    
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
      else 
        flash.now[:notice] = "You haven't updated user successfully."     
        render :edit
      end 
    end
    
    private
  
    def user_params
     params.require(:user).permit(:name, :introduction, :profile_image) 
    end
end
