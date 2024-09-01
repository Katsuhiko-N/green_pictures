class User::UsersController < ApplicationController
  def mypage
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    
    # 自分のページ開いたらマイページへ遷移
    if @user.id == current_user.id
      redirect_to mypage_users_path
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
  end

  def withdraw
    user = User.find(current_user.id)
    user.update(is_active: false)
    redirect_to test_path
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :nickname, :image, :email, :body, :password, :password_confirmation)
  end
  
  
end
