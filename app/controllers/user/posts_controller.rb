class User::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to posts_path
    else
      @post = Post.new
      render :new
    end
    
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to posts_path
    else
      @post = Post.find(params[:id])
      render :edit
    end
  end

  def destroy
    @post = post.find(params[:id])
    
    if @post.destroy
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end
  


  private
  
  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
end
