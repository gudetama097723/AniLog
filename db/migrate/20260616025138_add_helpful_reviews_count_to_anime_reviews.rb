class AddHelpfulReviewsCountToAnimeReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :anime_reviews,
               :helpful_reviews_count,
               :integer,
               null: false,
               default: 0
  end
end
