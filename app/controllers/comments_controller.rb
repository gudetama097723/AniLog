class CommentsController < ApplicationController
  def create
    anime_review = AnimeReview.find(params[:anime_review_id])
    comment = anime_review.comments.new(comment_params)
    comment.user = Current.user

    if comment.save
      redirect_to anime_review_path(anime_review), notice: "コメントを投稿しました"
    else
      redirect_to anime_review_path(anime_review), alert: "コメントを入力してください"
    end
  end

  def destroy
    anime_review = AnimeReview.find(params[:anime_review_id])
    comment = anime_review.comments.find(params[:id])

    if comment.user == Current.user
      comment.destroy
      redirect_to anime_review_path(anime_review), notice: "コメントを削除しました"
    else
      redirect_to anime_review_path(anime_review), alert: "削除できるのは自分のコメントのみです"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end