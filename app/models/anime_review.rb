class AnimeReview < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true
end
