class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create guest_login ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to mypage_path, notice: "ログインしました。"
    else
      redirect_to new_session_path, alert: "メールアドレスまたはパスワードが正しくありません。"
    end
  end

  def destroy
    terminate_session
    redirect_to about_path, notice: "ログアウトしました。"
  end

  def guest_login
    start_new_session_for(User.guest)
    redirect_to mypage_path, notice: "ゲストユーザーとしてログインしました"
  end

end
