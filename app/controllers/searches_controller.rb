class SearchesController < ApplicationController
    
    # 検索機能 
    def search
        word = search_params[:word] 
        model = search_params[:model]
        
        if model == "post"
            @posts = Post.where("title LIKE ?", "%#{word}%").or Post.where("body LIKE ?", "%#{word}%")
        else
            @users = User.where("nickname LIKE ?", "%#{word}%")
        end
    end
    
    private
    
    def search_params
        params.permit(:word, :model)
    end
    
    
    
end
