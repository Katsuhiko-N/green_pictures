class User::TagListsController < ApplicationController
  # ログインしているか
  before_action :authenticate_user!

    def destroy
        t_list = TagList.find_by(post_id: params[:post_id], tag_id: params[:tag_id])
        t_list.destroy
        
        # 投稿と一個も結びつきのなくなったタグを削除
        tags = Tag.left_outer_joins(:tag_lists).where(tag_lists: { id: nil })
        tags.destroy_all
        
        redirect_to post_path(params[:post_id])
    end
    
end
