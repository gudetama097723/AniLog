class SearchesController < ApplicationController
  def index
    @target = params[:target]
    @keyword = params[:keyword]
    @sort = params[:sort].presence || "newest"

    @anime_reviews = AnimeReview.none
    @users = User.none

    if @keyword.present?
      if @target == "anime_reviews"
        @anime_reviews = AnimeReview
          .left_joins(:genre)
          .includes(:user, :genre)
          .where(
            "anime_reviews.title LIKE ? OR anime_reviews.body LIKE ? OR genres.name LIKE ?",
            "%#{@keyword}%",
            "%#{@keyword}%",
            "%#{@keyword}%"
          )

        @anime_reviews =
          case @sort
          when "rating"
            @anime_reviews.order(rating: :desc, created_at: :desc)
          when "helpful"
            @anime_reviews.order(helpful_reviews_count: :desc, created_at: :desc)
          when "comments"
            @anime_reviews.order(comments_count: :desc, created_at: :desc)
          else
            @anime_reviews.order(created_at: :desc)
          end

      elsif @target == "users"
        @users = User.where(
          "name LIKE ? OR introduction LIKE ?",
          "%#{@keyword}%",
          "%#{@keyword}%"
        )

        @users =
          case @sort
          when "helpful"
            @users
              .left_joins(anime_reviews: :helpful_reviews)
              .includes(:anime_reviews)
              .group("users.id")
              .order("COUNT(helpful_reviews.id) DESC, users.created_at DESC")
          when "followers"
            @users
              .left_joins(:passive_relationships)
              .includes(:anime_reviews)
              .group("users.id")
              .order("COUNT(relationships.id) DESC, users.created_at DESC")
          else
            @users
              .includes(:anime_reviews)
              .order(created_at: :desc)
          end
      end
    end
  end
end
