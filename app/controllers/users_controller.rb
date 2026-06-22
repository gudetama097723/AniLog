class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def mypage
    @user = Current.user
    @tab =
      if params[:tab].in?(%w[mine following helpful])
        params[:tab]
      else
        "mine"
      end

    @anime_reviews =
      case @tab
      when "following"
        AnimeReview
          .where(user_id: @user.following.select(:id))
         .includes(:user, :genre)
          .order(created_at: :desc)
      when "helpful"
        @helpful_reviews = @user.helpful_reviews
          .includes(anime_review: [:user, :genre])
          .order(created_at: :desc)

        @helpful_reviews.map(&:anime_review)
      else
        @user.anime_reviews
          .includes(:user, :genre)
          .order(created_at: :desc)
      end
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
    if @user.guest?
      redirect_to mypage_path, alert: "ゲストユーザーはプロフィールを編集できません"
      return
    end

    if @user.update(user_update_params)
      redirect_to mypage_path, notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @sort = params[:sort].presence || "newest"

    @users =
      case @sort
      when "helpful"
        User
          .left_joins(anime_reviews: :helpful_reviews)
          .includes(:anime_reviews)
          .group("users.id")
          .order("COUNT(helpful_reviews.id) DESC, users.created_at DESC")
      when "followers"
        User
          .left_joins(:passive_relationships)
          .includes(:anime_reviews)
          .group("users.id")
          .order("COUNT(relationships.id) DESC, users.created_at DESC")
      else
        User
          .includes(:anime_reviews)
          .order(created_at: :desc)
      end
  end

  def show
    @anime_reviews = @user.anime_reviews.order(created_at: :desc)
  end

  def destroy
    if @user.guest?
      redirect_to mypage_path, alert: "ゲストユーザーは退会できません"
      return
    end
    
    @user.destroy
    cookies.delete(:session_id)
    redirect_to new_user_path
  end



  def connections
    @user = User.find(params[:id])
    @tab = params[:tab] == "followers" ? "followers" : "following"

    @users =
      if @tab == "followers"
        @user.followers.includes(:anime_reviews)
      else
        @user.following.includes(:anime_reviews)
      end
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
    params.require(:user).permit(:name, :email_address, :introduction, :image)
  end
end

