class User::UsersController < ApplicationController
  # ログインしているか
  before_action :authenticate_user!
  # アクセスしているユーザーはログインユーザーか？
  # 他人が勝手にいじれないように
  before_action :is_matching_login_user, only:[:update, :withdraw]
  # ゲストユーザーか？
  before_action :ensure_guest_user, except:[:show]
  
  def mypage
    @user = User.find(current_user.id)
    @groups = @user.groups.page(params[:page])
  end


  def show
    @user = User.find(params[:id])
    @groups = @user.groups.page(params[:page])
    # 自分のページ開いたらマイページへ遷移
    if  user_signed_in?
      # 閲覧しているユーザープロフィール＝閲覧者ならマイページ
      if @user.id == current_user.id
        redirect_to mypage_users_path
      end
    end
  end


  def edit
    @user = User.find(current_user.id)
  end


  def update
    @user = User.find(current_user.id)
    
    if @user.update(user_params)
      flash[:notice] = "編集されました"
      redirect_to mypage_users_path
    else
      render :edit
    end
  end


  def unsubscribe
    @user = User.find(current_user.id)
  end


  def withdraw
    user = User.find(current_user.id)
    user.update(is_active: false)
    reset_session
    redirect_to new_user_registration_path
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
  
  # ゲストユーザーか識別# ゲストユーザーか識別
  def ensure_guest_user
    @user = User.find(current_user.id)
    if @user.guest_user?
        redirect_to posts_path, notice: "ゲストユーザーはこの操作を実行できません"
    end
  end
  
  
end
