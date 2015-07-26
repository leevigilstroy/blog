class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
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
      flash[:success] = "Profile Updated"
    else
      render 'edit' end
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
  
  #before filters
  #ensures user is logged in before access
   def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end
  
  #ensures correct user is logged in as user they wish to edit / update
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
  
    
  
end
