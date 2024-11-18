class User::TagListsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  
    def destroy
        t_list = TagList.find_by(post_id: params[:post_id], tag_id: params[:tag_id])
        t_list.destroy
        
        # 投稿と一個も結びつきのなくなったタグを削除
        tags = Tag.left_outer_joins(:tag_lists).where(tag_lists: { id: nil })
        tags.destroy_all
        
        redirect_to post_path(params[:post_id])
    end
    
    # ゲストユーザーか識別# ゲストユーザーか識別
    def ensure_guest_user
        @user = User.find(current_user.id)
        if @user.guest_user?
            redirect_to posts_path, notice: "ゲストユーザーはこの操作を実行できません"
        end
    end
    
    
end