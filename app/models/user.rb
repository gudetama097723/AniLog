class User < ApplicationRecord
  has_one_attached :image
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :anime_reviews, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true

end
