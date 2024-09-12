class Admin::PostsController < ApplicationController
  # admin用レイアウト
  layout 'admin_application'
  
  # 管理者ログインしているか
  before_action :authenticate_admin!
  
  
  
  def index
    @posts = Post.all
  end


  def show
    @post = Post.find(params[:id])
    
    # コメント投稿フォーム用
    @comment = Comment.new
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
