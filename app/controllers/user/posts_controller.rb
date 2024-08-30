class User::PostsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    # ジャンル選択機能は後で実装
    
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to posts_path
    else
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
      flash[:notice] = "編集されました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "正常に削除されました"
    redirect_to posts_path
  end
  


  private
  
  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
end
