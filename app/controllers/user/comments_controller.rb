class User::CommentsController < ApplicationController
  # ログインしているか
  before_action :authenticate_user!
  # 操作しているユーザーはログインユーザーか？
  before_action :is_matching_login_user, only: [:destroy]
  
  
  def create
    post = Post.find(params[:post_id])
    # post.user_id=current_user_idでインスタンス作成
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(params[:post_id])
  end


  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end
  
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  # 投稿者認証
  def is_matching_login_user
    user = Comment.find(params[:id]).user
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end
  
end
