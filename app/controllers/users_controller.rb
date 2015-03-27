class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
   if @user.save
     redirect_to @user
   else
     redirect_to new_user_path
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params([:id])
  end
  
  def update
     @user = User.find(params([:id])
    if @user.save
      redirect_to @user
    end
  end
  
  def delete
    @user = User.find(params([:id])
  end
  
  def destroy
    @user = User.find(params([:id])
    @user.destroy
    redirect_to root
  end
  
  private
    
  def user_params
    User.params.require(:user).permit(:name, :email)
  end
  
end
