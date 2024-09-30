class User::GroupsController < ApplicationController
  
  # ログインしているか
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update, :destroy]
  
  # グループ参加人数呼び出しメソッド
  helper_method :g_count
  # 簡易ユーザー呼び出しメソッド
  helper_method :g_user
  # グループ加入済みか確認
  helper_method :is_member?
  
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    
    if @group.save
      flash[:notice] = "投稿に成功しました"
      
      # 組合せ（メンバー）作成=オーナー用
      g_mem = GroupMember.new(group_id: @group.id)
      g_mem.user_id = current_user.id
      g_mem.is_active = "true"
      g_mem.save
      
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end

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
    @g_messages = GroupMessage.all.order("id DESC")
    # ページネーション
    @g_messages = @g_messages.page(params[:page])
    
    # グループメッセージ投稿フォーム用
    @g_message = GroupMessage.new

  end



  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(group_params)
    if @group.update
      flash[:notice] = "保存に成功しました"
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end


  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end
  
  
  
  private
  
  def group_params
    params.require(:group).permit(:title, :body)
  end
  
  # オーナー認証
  def is_matching_login_user
    owner = Group.find(params[:id]).owner_id
    unless owner == current_user.id
      redirect_to groups_path
    end
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
