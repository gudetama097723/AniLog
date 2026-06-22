class AnimeReview < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  has_many :comments, dependent: :destroy
  has_many :helpful_reviews, dependent: :destroy
  has_many :helped_users,
           through: :helpful_reviews,
           source: :user

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true
end
