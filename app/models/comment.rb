class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :anime_review

  validates :body, presence: true
end
