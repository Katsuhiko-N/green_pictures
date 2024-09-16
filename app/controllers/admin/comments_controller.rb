class Admin::CommentsController < ApplicationController
  # admin用レイアウト
  layout 'admin_application'
  # 管理者ログインしているか
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.all
  end
  

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id])
  end
  
  def idx_destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_comments_path
  end
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  
end
