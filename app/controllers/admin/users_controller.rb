class Admin::UsersController < ApplicationController
  layout 'admin_application'
  before_action :authenticate_admin!

  
  def index
    @users = User.all
  end
  
  
  def show
    @user = User.find(params[:id])
    @groups = @user.groups.page(params[:page])
  end


  def update
    user = User.find(params[:id])
    
    if user.is_active == true
      if user.update(is_active: "false")
        flash[:notice] = "ステータス変更されました"
        redirect_to admin_user_path(user.id)
      else
        flash[:notice] = "ステータス変更失敗"
        render :edit
      end
    else
      if user.update(is_active: "true")
        flash[:notice] = "ステータス変更されました"
        redirect_to admin_user_path(user.id)
      else
        flash[:notice] = "ステータス変更失敗"
        render :edit
      end
    end
    
  end


  
  private
  
  def user_params
    params.require(:user).permit(:name, :nickname, :image, :email, :body, :password, :password_confirmation)
  end
  
  # ユーザー認証
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_users_path
    end
  end
  
end
