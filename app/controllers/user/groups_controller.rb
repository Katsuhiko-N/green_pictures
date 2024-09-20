class User::GroupsController < ApplicationController
    # ログインしているか
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update, :destroy]
  
  # 試験用
  helper_method :guser
  
  # オーナー名呼び出しメソッド
  helper_method :owner_n_name
  
  # グループ参加人数呼び出しメソッド
  helper_method :g_count
  
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    
    if @group.save
      flash[:notice] = "投稿に成功しました"
      
      # 組合せ（メンバー）作成
      g_comb = GroupCombination.new(group_id: @group.id)
      g_comb.user_id = current_user.id
      g_comb.save
      
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end

  def index
    @groups = Group.all
    
  end

  def show
    @group = Group.find(params[:id])
    
    # グループ組合せ試験用
    @gcomb = GroupCombination.all
    
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
  
  
  # オーナーのニックネーム呼び出し
  def owner_n_name(id)
    owner = Group.find(id).owner_id
    ownername = User.find(owner).nickname
    return ownername
  end
  
  
  # グループ参加人数呼び出し
  def g_count(number)
    counts = GroupCombination.where(group_id: number).count
    return counts
  end
  
  
  
  # グループ組合せ試験用
  def guser(user)
    name = User.find(user).nickname
    return name
  end
  
  
end
