class Genre < ApplicationRecord
  has_many :anime_reviews

  validates :name, presence: true, uniqueness: true
end
