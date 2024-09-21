class User::GroupMembersController < ApplicationController
    
    # ログインしているか
    before_action :authenticate_user!
  
    # 既にメンバーか？
    before_action :is_member?, only:[:create]
    
    
    def create
      g_mem = GroupMember.new(group_id: params[:group_id])
      g_mem.user_id = current_user.id
      g_mem.save
      redirect_to group_path(params[:group_id])
    end
  
    def destroy
      group = Group.find(params[:id])
      g_mem = GroupMember.find_by(user_id: current_user.id, group_id: group.id)
      g_mem.destroy
      redirect_to group_path(params[:group_id])
    end
    
    private
    
    def is_member?
      if GroupMember.exists?(group_id: params[:id], user_id: current_user.id)
        redirect_to group_path(params[:group_id])
      end
    end
    
    
end
