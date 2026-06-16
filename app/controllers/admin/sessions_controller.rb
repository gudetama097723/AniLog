class Admin::SessionsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create, :destroy]

  def new
  end

  def create
    admin = Admin.authenticate_by(params.permit(:login_id, :password))

    if admin
      session[:admin_id] = admin.id
      redirect_to admin_users_path, notice: "管理者としてログインしました"
    else
      redirect_to admin_sign_in_path, alert: "IDまたはパスワードが正しくありません"
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to admin_sign_in_path, notice: "管理者ログアウトしました"
  end
end
