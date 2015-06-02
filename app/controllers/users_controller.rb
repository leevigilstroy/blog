class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
   def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to my sample app!"
      redirect_to @user
    else
      render 'new'
    end
   end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
     @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to root_path
      flash[:success] = "Details Updated"
    end
  end
  
  def delete
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
  
  private
    
  def user_params
    params.require(:user).permit(:admin, :name, :email, :password, :password_confirmation)
  end
  
end
