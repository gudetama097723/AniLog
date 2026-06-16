class User < ApplicationRecord
  has_one_attached :image
  has_secure_password
  
  has_many :sessions, dependent: :destroy
  has_many :anime_reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true

  has_many :active_relationships,
           class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy

  has_many :passive_relationships,
           class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

  has_many :following,
           through: :active_relationships,
           source: :followed

  has_many :followers,
           through: :passive_relationships,
           source: :follower

  has_many :helpful_reviews, dependent: :destroy
  has_many :helpful_anime_reviews,
           through: :helpful_reviews,
           source: :anime_review

  def follow(user)
    following << user unless self == user
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id)&.destroy
  end

  def following?(user)
    following.include?(user)
  end

  def self.guest
    find_or_create_by!(email_address: "guest@example.com") do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
      user.introduction = "ゲストログイン用のユーザーです。"
    end
  end

  def guest?
    email_address == "guest@example.com"
  end

end
