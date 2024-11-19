class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update, :destroy]
  before_action :ensure_guest_user, except:[:index, :show]
  
  def new
    @post = Post.new
    @tag = Tag.new
  end


  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @tag = Tag.new(tag_params)
    
    if tag_params[:name].blank?
      if @post.save
        flash[:notice] = "投稿に成功しました"
        redirect_to post_path(@post.id)
      else
        render :new
      end
    else
      # タグ入力した場合
      if @post.save
        flash[:notice] = "投稿に成功しました"
        
        # 同じ名前のタグあるか検索
        same_tag = Tag.find_by(name: @tag.name)
        
        if same_tag == nil
          # 新規タグの場合新規生成
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
          # 既存タグは組合せ（tag_list）だけ保存
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
  end
  
  
  def index
    # ページネーション
    @posts = Post.all.order("created_at DESC")
  end


  def show
    @post = Post.find(params[:id])
    
    # コメント投稿フォーム用
    @comment = Comment.new
    # コメントリスト用
    comments = @post.comments
    @comments_p = comments.page(params[:page])
    
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
  
  # ゲストユーザーか識別# ゲストユーザーか識別
  def ensure_guest_user
      @user = User.find(current_user.id)
      if @user.guest_user?
          redirect_to posts_path, notice: "ゲストユーザーはこの操作を実行できません"
      end
  end
  
end