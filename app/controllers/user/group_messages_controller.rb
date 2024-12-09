class User::GroupMessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_guest_user
    
    def create
        @g_message = GroupMessage.new(message_params)
        @g_message.user_id = current_user.id
        @g_message.group_id = params[:group_id]
        if @g_message.save
            flash[:notice] = "投稿されました"
            redirect_to group_path(params[:group_id])
        else
            flash[:alert] = "投稿に失敗しました..."
            redirect_to group_path(params[:group_id])
        end
    end
    
    def destroy
        g_message = GroupMessage.find(params[:id])
        g_message.destroy
        redirect_to group_path(params[:group_id])
    end
    
    
    private
    
    def message_params
        params.require(:group_message).permit(:body)
    end
    
    
    # ゲストユーザーか識別# ゲストユーザーか識別
    def ensure_guest_user
        @user = User.find(current_user.id)
        if @user.guest_user?
            redirect_to posts_path, notice: "ゲストユーザーはこの操作を実行できません"
        end
    end
    
end
