class HelpfulReviewsController < ApplicationController
  def create
    anime_review = AnimeReview.find(params[:anime_review_id])

    if anime_review.user == Current.user
      redirect_to anime_review_path(anime_review), alert: "自分の投稿は参考にした投稿へ追加できません"
      return
    end

    Current.user.helpful_reviews.find_or_create_by!(anime_review: anime_review)

    redirect_to anime_review_path(anime_review), notice: "参考にした投稿へ追加しました"
  end

  def destroy
    helpful_review = Current.user.helpful_reviews.find(params[:id])
    anime_review = helpful_review.anime_review

    helpful_review.destroy

    redirect_to anime_review_path(anime_review), notice: "参考にした投稿から解除しました"
  end

  def toggle_collapsed
    helpful_review = Current.user.helpful_reviews.find(params[:id])
    helpful_review.update!(collapsed: !helpful_review.collapsed)

    redirect_to mypage_path(tab: "helpful")
  end
end
