class Admin::TagsController < ApplicationController
  # admin用レイアウト
  layout 'admin_application'
  
  # 管理者ログインしているか
  before_action :authenticate_admin!
    
    def index
        @tags = Tag.all
    end
    
    def destroy
        tag = Tag.find(params[:id])
        tag.destroy
        render :index
    end
end
