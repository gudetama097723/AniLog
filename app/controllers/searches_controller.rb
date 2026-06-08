class SearchesController < ApplicationController
  def index
    @target = params[:target]
    @keyword = params[:keyword]

    @anime_reviews = AnimeReview.none
    @users = User.none

    if @keyword.present?
      if @target == "anime_reviews"
        @anime_reviews = AnimeReview.where("title LIKE ? OR body LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
      elsif @target == "users"
        @users = User.where("name LIKE ? OR introduction LIKE ?", "%#{@keyword}%", "%#{@keyword}%")
      end
    end
  end
end
