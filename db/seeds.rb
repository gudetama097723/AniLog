# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
demo_users = [
  {
    name: "デモ太郎",
    email_address: "demo_taro@example.com",
    password: "password",
    introduction: "バトルアニメや王道ストーリーが好きです。"
  },
  {
    name: "デモ花子",
    email_address: "demo_hanako@example.com",
    password: "password",
    introduction: "日常系アニメを中心にレビューしています。"
  },
  {
    name: "デモ一郎",
    email_address: "demo_ichiro@example.com",
    password: "password",
    introduction: "作画や演出に注目してアニメを見ています。"
  }
]

users = demo_users.map do |user_params|
  User.find_or_create_by!(email_address: user_params[:email_address]) do |user|
    user.name = user_params[:name]
    user.password = user_params[:password]
    user.introduction = user_params[:introduction]
  end
end

anime_reviews = [
  {
    user: users[0],
    title: "星空ランナー",
    body: "夢に向かって走り続ける主人公の姿が印象的でした。最終話の演出が特に良かったです。",
    rating: 5
  },
  {
    user: users[0],
    title: "魔法喫茶ミルキー",
    body: "キャラクター同士の会話が楽しく、気軽に見られる作品でした。",
    rating: 4
  },
  {
    user: users[1],
    title: "放課後スケッチ",
    body: "日常の小さな出来事を丁寧に描いていて、見終わったあとに温かい気持ちになりました。",
    rating: 5
  },
  {
    user: users[1],
    title: "海辺のメロディ",
    body: "音楽と風景描写がきれいで、落ち着いた雰囲気の作品でした。",
    rating: 4
  },
  {
    user: users[2],
    title: "機械都市のリベリオン",
    body: "世界観の作り込みがよく、アクションシーンのテンポも良かったです。",
    rating: 4
  }
]

anime_reviews.each do |review_params|
  AnimeReview.find_or_create_by!(
    user: review_params[:user],
    title: review_params[:title]
  ) do |review|
    review.body = review_params[:body]
    review.rating = review_params[:rating]
  end
end