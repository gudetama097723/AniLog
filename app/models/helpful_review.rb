class HelpfulReview < ApplicationRecord
  belongs_to :user
  belongs_to :anime_review, counter_cache: true
end
