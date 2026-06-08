class AddGenreToAnimeReviews < ActiveRecord::Migration[8.0]
  def change
    add_reference :anime_reviews, :genre, foreign_key: true
  end
end
