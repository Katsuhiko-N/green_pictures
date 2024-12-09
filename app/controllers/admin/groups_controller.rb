class Admin::GroupsController < ApplicationController
  layout 'admin_application'
  before_action :authenticate_admin!
  

  def index
    @groups = Group.page(params[:page])
    
  end

  def show
    @group = Group.find(params[:id])
    
    # グループメッセージ一覧取得（降順）
    @g_messages = GroupMessage.where(group_id: params[:id]).all.order("id DESC").page(params[:page])
    
    @g_message = GroupMessage.new

  end


  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to admin_groups_path
  end
  
  
  private
  
  def group_params
    params.require(:group).permit(:title, :body)
  end
    
end
