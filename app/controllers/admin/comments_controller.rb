class Admin::CommentsController < ApplicationController
  
  # 管理者ログインしているか
  before_action :authenticate_admin!
  

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id])
  end
  
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  
end
