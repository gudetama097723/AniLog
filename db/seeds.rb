# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
genres = {
  battle: Genre.find_or_create_by!(name: "バトル"),
  daily: Genre.find_or_create_by!(name: "日常"),
  fantasy: Genre.find_or_create_by!(name: "ファンタジー"),
  sf: Genre.find_or_create_by!(name: "SF"),
  music: Genre.find_or_create_by!(name: "音楽")
}

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
    rating: 5,
    genre: genres[:battle]
  },
  {
    user: users[0],
    title: "魔法喫茶ミルキー",
    body: "キャラクター同士の会話が楽しく、気軽に見られる作品でした。",
    rating: 4,
    genre: genres[:daily]
  },
  {
    user: users[1],
    title: "放課後スケッチ",
    body: "日常の小さな出来事を丁寧に描いていて、見終わったあとに温かい気持ちになりました。",
    rating: 5,
    genre: genres[:daily]
  },
  {
    user: users[1],
    title: "海辺のメロディ",
    body: "音楽と風景描写がきれいで、落ち着いた雰囲気の作品でした。",
    rating: 4,
    genre: genres[:music]
  },
  {
    user: users[2],
    title: "機械都市のリベリオン",
    body: "世界観の作り込みがよく、アクションシーンのテンポも良かったです。",
    rating: 4,
    genre: genres[:battle]
  }
]

anime_reviews.each do |review_params|
  review = AnimeReview.find_or_initialize_by(
    user: review_params[:user],
    title: review_params[:title]
  )

  review.update!(
    body: review_params[:body],
    rating: review_params[:rating],
    genre: review_params[:genre]
  )
end

Comment.find_or_create_by!(
  user: users[1],
  anime_review: AnimeReview.find_by!(title: "星空ランナー"),
  body: "最終話の演出、私もすごく好きでした。"
)

Comment.find_or_create_by!(
  user: users[2],
  anime_review: AnimeReview.find_by!(title: "放課後スケッチ"),
  body: "日常描写が丁寧で癒されますよね。"
)