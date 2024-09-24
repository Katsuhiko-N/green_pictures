class User::TagsController < ApplicationController
    
    
    def create
        tag = Tag.new(tag_params)
        if tag.save
            t_list = TagList.new
            t_list.post_id = params[:post_id]
            t.list.tag_id = params[:id]
            flash[:notice] = "投稿に成功しました"
            redirect_to post_path(params[:post_id])
        else
          render :new
        end
    end
    
    
    def index
        @tags = Tag.all
        
    end
    
    
    # タグを削除（管理者用）   
    def destroy
        tag = Tag.find(params[:id])
        tag.destroy
        redirect_to post_path(params[:post_id])
    end
    
    
    
    private
    
    def tag_params
        params.require(:tag).permit(:body)
    end
    
    
    
end
