class User::TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, except:[:index]
    
    def create
        @tag = Tag.new(tag_params)
        
        # 同じ名前のタグあるか検索
        same_tag = Tag.find_by(name: @tag.name)
           
        # 既に同じ名前のタグがある（既存のタグ）かどうか
        if same_tag == nil
            # 存在しない場合タグと中間テーブルを新規登録
            if @tag.save
                t_list = TagList.new
                t_list.post_id = params[:post_id]
                t_list.tag_id = @tag.id
                t_list.save
                flash[:notice] = "タグの登録に成功しました"
                redirect_to post_path(params[:post_id])
            else
                flash[:notice] = "保存に失敗しました"
                # postのshowアクションへ（以下表示用インスタンス変数）
                    @post = Post.find(params[:post_id])
                    # コメント投稿フォーム用
                    @comment = Comment.new
                    # コメントリスト用
                    comments = @post.comments
                    @comments_p = comments.page(params[:page])
                    # タグ表示用
                    @t_lists = TagList.where(post_id: params[:post_id])
                render template: "user/posts/show"
            end
        else
            # 既存のタグをつける場合
            if TagList.where(post_id: params[:post_id], tag_id: same_tag.id).exists?
                # 既に同じ投稿に同じタグがつけられている場合
                flash[:notice] = "1つの投稿に同じタグはつけられません"
                # postのshowアクションへ（以下表示用インスタンス変数）
                    @post = Post.find(params[:post_id])
                    # コメント投稿フォーム用
                    @comment = Comment.new
                    # コメントリスト用
                    comments = @post.comments
                    @comments_p = comments.page(params[:page])
                    # タグ表示用
                    @t_lists = TagList.where(post_id: params[:post_id])
                render template: "user/posts/show"
            else
                # 名前重複した場合同じ名前のタグは組合せ（tag_list）だけ保存
                t_list = TagList.new
                t_list.post_id = params[:post_id]
                t_list.tag_id = same_tag.id
                t_list.save
                flash[:notice] = "タグの登録に成功しました"
                redirect_to post_path(params[:post_id])
            end
        end
    end
    
    
    def index
        @tags = Tag.page(params[:page])
    end
    
    
    private
    
    def tag_params
        params.require(:tag).permit(:name)
    end
    
    # ゲストユーザーか識別# ゲストユーザーか識別
    def ensure_guest_user
        @user = User.find(current_user.id)
        if @user.guest_user?
            redirect_to posts_path, notice: "ゲストユーザーはこの操作を実行できません"
        end
    end
    
end
