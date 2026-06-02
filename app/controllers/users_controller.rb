class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def mypage
    @user = Current.user
    @anime_reviews = @user.anime_reviews.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_session_path, notice: "新規登録が完了しました。ログインしてください。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_update_params)
      redirect_to mypage_path, notice: "ユーザー情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    cookies.delete(:session_id)
    redirect_to new_user_path
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless @user == Current.user
      redirect_to mypage_path, alert: "権限がありません。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email_address)
  end
end

