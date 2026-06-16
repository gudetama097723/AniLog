class AddCommentsCountToAnimeReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :anime_reviews,
               :comments_count,
               :integer,
               null: false,
               default: 0
  end
end
