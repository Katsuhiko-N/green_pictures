class User::SearchesController < ApplicationController
      before_action :authenticate_user!
  
    # 検索機能 
    def search
        word = search_params[:word] 
        model = search_params[:model]
        time = search_params[:time]
        
        # wordが存在するかで分岐
        # なし＝グループ用検索
        if word == nil
            # グループと関連かつ入会済みメンバーを選抜
            users = User.joins(:group_members).where('group_members.group_id = ? AND group_members.is_active = ?', params[:group_id], true)
            if model == "group_post"
                # # modelあり=グループメンバー投稿検索
                @posts = Post.where(user_id: users.ids)
                @posts.page(params[:page])
            else
                # modelなし=グループメンバーになったユーザー検索
                @users = users
            end
            
        # wordが存在＝通常検索
        else
            # ワードをスペース等で分割に対応、AND検索
            @keywords = word.split(/[[:blank:]]+/)
            
            # 以下modelの種類で分岐
            if model == "post"
                @posts = Post.all
                @keywords.each do |keyword|
                    # 繰り返すうちにallから絞り込まれる
                    @posts = @posts.where("title LIKE ? OR body LIKE ?", "%#{keyword}%", "%#{keyword}%")
                end
            elsif model == "user"
                @users = User.all
                @keywords.each do |keyword|
                    @users = @users.where("nickname LIKE ?", "%#{keyword}%").where.not(email: "guest@example.com")
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
            
            
            # timeがあれば日時で絞りこみ
            unless time.nil? || time.empty?
                unless @posts == nil
                    @posts = @posts.where("posts.created_at >= ?", Date.parse(time) )
                else
                    @users = @users.where("users.created_at >= ?", Date.parse(time) ).where.not(email: "guest@example.com")
                    
                end
            end
        end
    end
    
    private
    
    def search_params
        params.permit(:word, :model, :time)
    end
    
end
