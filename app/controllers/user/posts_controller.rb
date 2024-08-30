class User::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    # ジャンル選択機能は後で実装
    
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
      redirect_to post_path(@post.id)
    else
      @post = Post.find(params[:id])
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  


  private
  
  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
end
