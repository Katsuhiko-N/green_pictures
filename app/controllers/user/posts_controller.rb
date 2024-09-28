class User::PostsController < ApplicationController
  # ログインしているか
  before_action :authenticate_user!
  # アクセスしているユーザーはログインユーザーか？
  # 他人が勝手に投稿をいじれないように
  before_action :is_matching_login_user, only:[:edit, :update, :destroy]
  
  
  def new
    @post = Post.new
    @tag = Tag.new
  end


  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @tag = Tag.new(tag_params)
    
    if @post.save
      flash[:notice] = "投稿に成功しました"
      
      # 同じ名前のタグあるか検索
      same_tag = Tag.find_by(name: @tag.name)
      
      # 既に同じ名前のタグがあるかどうか
      if same_tag == nil
        
        if @tag.save
          t_list = TagList.new
          t_list.post_id = @post.id
          t_list.tag_id = @tag.id
          t_list.save
          flash[:notice] = "タグの登録に成功しました"
          redirect_to post_path(@post.id)
        else
          render :new
        end
        
      else
        
        # 同じ名前のタグは組合せ（tag_list）だけ保存
        t_list = TagList.new
        t_list.post_id = @post.id
        t_list.tag_id = same_tag.id
        t_list.save
        flash[:notice] = "タグの登録に成功しました"
        redirect_to post_path(@post.id)
        
      end
    else
      render :new
    end
  end
  
  
  def index
    @posts = Post.all
  end


  def show
    @post = Post.find(params[:id])
    
    # コメント投稿フォーム用
    @comment = Comment.new
    # タグ表示用
    @t_lists = TagList.where(post_id: params[:id])
    # タグ登録用
    @tag = Tag.new
    
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
    
    # 投稿と一個も結びつきのなくなったタグを削除
    tags = Tag.left_outer_joins(:tag_lists).where(tag_lists: { id: nil })
    tags.destroy_all
    
    redirect_to posts_path
  end
  


  private
  
  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
  
  def tag_params
      params.require(:tag).permit(:name)
  end
  
  # 投稿者認証
  def is_matching_login_user
    user = Post.find(params[:id]).user
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end
  
  
end