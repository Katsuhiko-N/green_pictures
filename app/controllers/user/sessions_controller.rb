# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]
  
  def after_sign_in_path_for(resource)
    posts_path
  end
  
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  private
  def user_state
    # emailと一致するアカウントを検索
    user = User.find_by(email: params[:user][:email])
    # nilなら終了
    return if user.nil?
    # パスワードが入力されたものと一致しない場合終了
    return unless user.valid_password?(params[:user][:password])
    # ステータスがtrueなら終了、falseならサインアップへ
    return if user.is_active == true
    redirect_to new_user_registration_path
  end
  
  
end
