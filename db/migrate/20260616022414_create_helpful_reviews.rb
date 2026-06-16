class CreateHelpfulReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :helpful_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :anime_review, null: false, foreign_key: true
      t.boolean :collapsed, null: false, default: false

      t.timestamps
    end

    add_index :helpful_reviews,
              [:user_id, :anime_review_id],
              unique: true
  end
end
