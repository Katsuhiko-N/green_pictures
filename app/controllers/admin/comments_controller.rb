class Admin::CommentsController < ApplicationController
  layout 'admin_application'
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.page(params[:page])
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
