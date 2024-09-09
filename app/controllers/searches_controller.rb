class SearchesController < ApplicationController
    
    # 検索機能 
    def search
        word = search_params[:word] 
        model = search_params[:model]
        
        if model == "post"
            @answer_p = Post.where("title LIKE ?", "%#{word}%").or Post.where("body LIKE ?", "%#{word}%")
        else
            @answer_u = User.where("nickname LIKE ?", "%#{word}%")
        end
        
        
    end
    
    # 検索機能 
    def search_bar
        
    end
    
    private
    
    def search_params
        params.permit(:word, :model)
    end
    
    
    
end
