class User::TagsController < ApplicationController
  # ログインしているか
  before_action :authenticate_user!
    
    def create
        @tag = Tag.new(tag_params)
        
        if @tag.save
            t_list = TagList.new
            t_list.post_id = params[:post_id]
            t_list.tag_id = @tag.id
            t_list.save!
            flash[:notice] = "投稿に成功しました"
            redirect_to post_path(params[:post_id])
        else
            flash[:notice] = "保存に失敗しました"
            
            # postのshowアクションへ（以下表示用インスタンス変数）
                @post = Post.find(params[:post_id])
                # コメント投稿フォーム用
                @comment = Comment.new
                # タグ表示用
                @t_lists = TagList.where(post_id: params[:post_id])
            render template: "user/posts/show"
        end
    end
    
    
    
    private
    
    def tag_params
        params.require(:tag).permit(:body)
    end
    
    
    
end
