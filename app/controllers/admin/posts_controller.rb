class Admin::PostsController < ApplicationController
  layout 'admin_application'
  before_action :authenticate_admin!
  
  
  
  def index
    @posts = Post.all.order("created_at DESC")
  end


  def show
    @post = Post.find(params[:id])
    
    @comments_p = @post.comments.page(params[:page])
    
    @t_lists = TagList.where(post_id: params[:id])
  end


  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      flash[:notice] = "編集されました"
      redirect_to admin_post_path(@post.id)
    else
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "正常に削除されました"
    redirect_to admin_posts_path
  end
  


  private
  
  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
  
  
end
