class Admin::GroupsController < ApplicationController
    # admin用レイアウト
  layout 'admin_application'
    
  # ログインしているか
  before_action :authenticate_admin!
  
  # グループ参加人数呼び出しメソッド
  helper_method :g_count
  # 簡易ユーザー呼び出しメソッド
  helper_method :g_user
  # グループ加入済みか確認
  helper_method :is_member?
  

  def index
    # ページネーション
    @groups = Group.page(params[:page])
    
  end

  def show
    @group = Group.find(params[:id])

    # 加入済みメンバーリスト
    @g_mems = GroupMember.where(group_id: params[:id], is_active: "true")
    # ページネーション
    @g_mems = @g_mems.page(params[:page])
    
    # グループメッセージ一覧用（降順）
    @g_messages = GroupMessage.where(group_id: params[:id]).all.order("id DESC")
    # ページネーション
    @g_messages = @g_messages.page(params[:page])
    
    # グループメッセージ投稿フォーム用
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
  

  
  # 簡易ユーザー呼び出し表示用
  def g_user(id)
    user = User.find(id)
    return user
  end
  
  # グループ参加人数呼び出し表示用
  def g_count(number)
    counts = GroupMember.where(group_id: number, is_active: true).count
    return counts
  end
  
  # メンバー加入状態確認メソッド
  def is_member?(userid)
    return GroupMember.exists?(group_id: params[:id], user_id: userid , is_active: "true")
  end
    
    
end
