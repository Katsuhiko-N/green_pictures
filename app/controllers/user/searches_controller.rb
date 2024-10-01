class User::SearchesController < ApplicationController
      # ログインしているか
      before_action :authenticate_user!
  
    # 検索機能 
    def search
        word = search_params[:word] 
        model = search_params[:model]
        
        if word == nil
            # wordが存在しない＝グループ用検索
            # グループ投稿検索
            if model == "group_post"
                users = User.joins(:group_members).where('group_members.group_id = ? AND group_members.is_active = ?', params[:group_id], true)
                # 投稿から絞り込んだusersのidと一致するものを抜き出す
                @posts = Post.where(user_id: users.ids)
                
                @posts.page(params[:page])
            else
                # グループユーザー検索
                @users = User.joins(:group_members).where('group_members.group_id = ? AND group_members.is_active = ?', params[:group_id], true)
            end
            
        else
            # wordが存在＝通常検索
            # ワードをスペース等で分割、AND検索
            @keywords = word.split(/[[:blank:]]+/)
            
            if model == "post"
                @posts = Post.all
                @keywords.each do |keyword|
                    # 繰り返すうちにallから絞り込まれる
                    @posts = @posts.where("title LIKE ? OR body LIKE ?", "%#{keyword}%", "%#{keyword}%")
                end
            elsif model == "user"
                @users = User.all
                @keywords.each do |keyword|
                    @users = @users.where("nickname LIKE ?", "%#{keyword}%")
                end
            elsif model == "tag"
                tags = Tag.all
                @keywords.each do |keyword|
                    # 繰り返すうちにallから絞り込まれる
                    tags = tags.where("name LIKE ?", "%#{keyword}%")
                end
                
                @posts = Post.joins(:tag_lists).where('tag_lists.tag_id IN (?)', tags.ids)
                
            else
                # タグ一覧（検索ではなく投稿一覧）
                tags = Tag.all
                @keywords.each do |keyword|
                    # 繰り返すうちにallから絞り込まれる
                    tags = tags.where(name: keyword)
                end
                
                @posts = Post.joins(:tag_lists).where('tag_lists.tag_id IN (?)', tags.ids)
            end
            
        end
    end
    
    private
    
    def search_params
        params.permit(:word, :model, :keyword)
    end
    
end
