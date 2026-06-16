class Admin::AnimeReviewsController < Admin::BaseController
  def index
    @anime_reviews = AnimeReview.includes(:user).order(created_at: :desc)
  end

  def show
    @anime_review = AnimeReview.find(params[:id])
  end

  def destroy
    anime_review = AnimeReview.find(params[:id])
    anime_review.destroy
    redirect_to admin_anime_reviews_path, notice: "レビューを削除しました"
  end
end
