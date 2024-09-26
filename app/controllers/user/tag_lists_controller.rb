class User::TagListsController < ApplicationController
  # ログインしているか
  before_action :authenticate_user!

    def destroy
        t_list = TagList.find_by(post_id: params[:post_id], tag_id: params[:tag_id])
        
        t_lists = TagList.where(tag_id: params[:tag_id])
        
        if t_lists.count > 1
          t_list.destroy
          redirect_to post_path(params[:post_id])
        else
          # 投稿との関連がなくなったタグを削除
          tag = Tag.find(params[:tag_id])
          tag.destroy
          redirect_to post_path(params[:post_id])
        end
    end
    
end
