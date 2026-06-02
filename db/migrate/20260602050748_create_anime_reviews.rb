class CreateAnimeReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :anime_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.integer :rating

      t.timestamps
    end
  end
end
