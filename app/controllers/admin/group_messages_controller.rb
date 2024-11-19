class Admin::GroupMessagesController < ApplicationController
    before_action :authenticate_admin!
  
    def destroy
        g_message = GroupMessage.find(params[:id])
        g_message.destroy
        redirect_to admin_group_path(params[:group_id])
    end
  
  
end
