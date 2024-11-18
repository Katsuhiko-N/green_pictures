class User::GroupMembersController < ApplicationController
    before_action :authenticate_user!
    before_action :is_member?, only:[:create]
    before_action :is_owner?, only:[:index, :update]
    before_action :ensure_guest_user
    
    
    def create
      g_mem = GroupMember.new(group_id: params[:group_id])
      g_mem.user_id = current_user.id
      g_mem.save
      redirect_to group_path(params[:group_id])
    end
    
    
    def index
      # オーナーを除外
      owner_id = Group.find(params[:group_id]).owner_id
      all_mems = GroupMember.where.not(user_id: owner_id)
      
      # 加入済み
      @g_mems = all_mems.where(group_id: params[:group_id], is_active: "true")
      # 未加入者
      @g_no_mems = all_mems.where(group_id: params[:group_id], is_active: "false")
    end
    
    
    def update
      g_mem = GroupMember.find_by(group_id: params[:group_id], user_id: params[:id])
      
      if g_mem.is_active == false
        g_mem.update(is_active: "true")
        flash[:notice] = "ステータスが変更されました"
        redirect_to group_group_members_path(params[:group_id])
      else
        g_mem.update(is_active: "false")
        flash[:notice] = "ステータスが変更されました"
        redirect_to group_group_members_path(params[:group_id])
      end
    end
    
    
    def destroy
      group = Group.find(params[:group_id])
      g_mem = GroupMember.find_by(user_id: params[:id], group_id: group.id)
      g_mem.destroy
      redirect_to group_path(params[:group_id])
    end
    
    
    
    private
    
    # オーナー認証
    def is_owner?
      owner_id = Group.find(params[:group_id]).owner_id
      unless current_user.id == owner_id
        redirect_to group_path(params[:group_id])
      end
    end
    
    
    # 既にメンバーなら詳細ページに戻る
    def is_member?
      if GroupMember.exists?(group_id: params[:id], user_id: current_user.id)
        redirect_to group_path(params[:group_id])
      end
    end
    
    
    # ゲストユーザーか識別
    def ensure_guest_user
      @user = User.find(current_user.id)
      if @user.guest_user?
       redirect_to posts_path, notice: "ゲストユーザーはこの操作を実行できません"
      end
    end
    
end
