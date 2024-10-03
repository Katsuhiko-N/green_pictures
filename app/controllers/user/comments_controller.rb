class User::CommentsController < ApplicationController
  # ログインしているか
  before_action :authenticate_user!
  # 操作しているユーザーは投稿者（コメントもしくは画像投稿者）ユーザーか？
  before_action :is_matching_user, only: [:destroy]
  # ゲストユーザーか？
  before_action :ensure_guest_user
  
  def create
    post = Post.find(params[:post_id])
    # post.user_id=current_user_idでインスタンス作成
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      @post = Post.find(params[:post_id])
      # コメントリスト用
      comments = @post.comments
      @comments_p = comments.page(params[:page])
      # タグ表示用
      @t_lists = TagList.where(post_id: params[:post_id])
      # タグ登録用
      @tag = Tag.new
      
      render template: "user/posts/show"
    end
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
  def is_matching_user
    # コメント投稿者
    c_user = Comment.find(params[:id]).user
    # 画像投稿者
    p_user = Post.find(params[:post_id]).user
    unless c_user.id == current_user.id || p_user.id == current_user.id
      redirect_to posts_path
    end
  end
  
  # ゲストユーザーか識別
  def ensure_guest_user
    @user = User.find(current_user.id)
    if @user.guest_user?
     redirect_to posts_path, notice: "ゲストユーザーはこの操作を実行できません"
    end
  end
  
end
