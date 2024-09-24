class User::TagListsController < ApplicationController
    
    
    
    def destroy
        t_list = TagList.find_by(post_id: params[:post_id], tag_id: params[:id])
        t_list.destroy
        redirect_to post_path(params[:post_id])
    end
    
end
