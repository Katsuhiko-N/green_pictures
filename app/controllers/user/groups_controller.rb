class User::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update, :destroy]
  before_action :ensure_guest_user, except:[:index, :show]
  
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
    @g_messages = GroupMessage.where(group_id: params[:id]).all.order("id DESC")
    # ページネーション
    @g_messages = @g_messages.page(params[:page])
    
    # グループメッセージ投稿フォーム用
    @g_message = GroupMessage.new

  end



  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
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
    params.require(:group).permit(:g_image, :title, :body)
  end
  
  # オーナー認証
  def is_matching_login_user
    owner = Group.find(params[:id]).owner_id
    unless owner == current_user.id
      redirect_to groups_path
    end
  end
  
  
  # メンバー加入状態確認メソッド
  def is_member?(userid)
    return GroupMember.exists?(group_id: params[:id], user_id: userid , is_active: "true")
  end
  
  # ゲストユーザーか識別
  def ensure_guest_user
      @user = User.find(current_user.id)
      if @user.guest_user?
          redirect_to posts_path, notice: "ゲストユーザーはこの操作を実行できません"
      end
  end

end
