class User::GroupMessagesController < ApplicationController
    
    # ログインしているか
    before_action :authenticate_user!
    
    
    
    def create
        @g_message = GroupMessage.new(message_params)
        @g_message.user_id = current_user.id
        @g_message.group_id = params[:group_id]
        if @g_message.save
            flash[:notice] = "編集されました"
            redirect_to group_path(params[:group_id])
        else
            render :create
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
    
    
end
