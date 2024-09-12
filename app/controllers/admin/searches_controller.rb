class Admin::SearchesController < ApplicationController
  # admin用レイアウト
  layout 'admin_application'
  
  # 管理者ログインしているか
  before_action :authenticate_admin!
  
  
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
