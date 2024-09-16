class User::GroupsController < ApplicationController
    # ログインしているか
  before_action :authenticate_user!
  
  def new
    @group = Group.new
    
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    
    if @group.save
      flash[:notice] = "投稿に成功しました"
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end

  def index
    @groups = Group.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destoroy
  end
  
  
  private
  
  def group_params
    params.require(:group).permit(:title, :body)
  end
  
  
end
