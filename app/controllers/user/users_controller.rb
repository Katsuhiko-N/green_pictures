class User::UsersController < ApplicationController
  def mypage
    @user = User.find(curent_user.id)
  end

  def edit
  end

  def show
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end
end
