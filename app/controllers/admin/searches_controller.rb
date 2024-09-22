class Admin::SearchesController < ApplicationController
  # admin用レイアウト
  layout 'admin_application'
  
  # 管理者ログインしているか
  before_action :authenticate_admin!
  
  
  # 検索機能 
    def search
        word = search_params[:word] 
        model = search_params[:model]
        
        # ワードをスペース等で分割、AND検索
        @keywords = word.split(/[[:blank:]]+/)
        
        if model == "post"
            @posts = Post.all
            @keywords.each do |keyword|
                # 繰り返すうちにallから絞り込まれる
                @posts = @posts.where("title LIKE ? OR body LIKE ?", "%#{keyword}%", "%#{keyword}%")
            end
        else
            @users = User.all
            @keywords.each do |keyword|
                @users = @users.where("nickname LIKE ?", "%#{keyword}%")
            end
        end
    end
    
    private
    
    def search_params
        params.permit(:word, :model)
    end
  
  
end
