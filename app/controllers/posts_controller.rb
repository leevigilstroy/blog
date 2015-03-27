class PostsController < ApplicationController

  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
   if @post.save
     redirect_to(:action => 'show', :id => @post.id)
   else
     redirect_to new_post_path
   end
  end
  

  
  def edit
    @post = Post.find(params([:id]))
  end
  
  def update
     @post = Post.find(params([:id]))
    if @post.save
      redirect_to(:action => 'show', :id => @post.id)
    end
  end
  
  def delete
    @post = Post.find(params([:id]))
  end
  
  def destroy
    @post = Post.find(params([:id]))
    @post.destroy
    redirect_to root_path
  end
    
    private
    
    def post_params
      params.require(:post).permit(:title, :content)
    end
  
end
