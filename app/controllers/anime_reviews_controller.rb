class AnimeReviewsController < ApplicationController
  before_action :set_anime_review, only: [:show, :edit, :update, :destroy]
  before_action :authorize_anime_review, only: [:edit, :update, :destroy]

  def index
    @anime_reviews = AnimeReview.order(created_at: :desc)
  end

  def show
    @comments = @anime_review.comments.order(created_at: :desc)
  end

  def new
    @anime_review = AnimeReview.new
  end

  def create
    @anime_review = Current.user.anime_reviews.new(anime_review_params)

    if @anime_review.save
      redirect_to anime_review_path(@anime_review), notice: "投稿しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @anime_review.update(anime_review_params)
      redirect_to anime_review_path(@anime_review), notice: "投稿を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @anime_review.destroy
    redirect_to anime_reviews_path, notice: "投稿を削除しました。"
  end

  private

  def set_anime_review
    @anime_review = AnimeReview.find(params[:id])
  end

  def authorize_anime_review
    unless @anime_review.user == Current.user
      redirect_to anime_reviews_path, alert: "権限がありません。"
    end
  end

  def anime_review_params
    params.require(:anime_review).permit(:title, :body, :rating, :genre_id)
  end
end
