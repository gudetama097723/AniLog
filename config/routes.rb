Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  root "homes#top"
  get "about" => "homes#about"
  get "mypage" => "users#mypage"

  resources :users, only: [:index, :show,:new, :create, :edit, :update, :destroy]
  resources :anime_reviews

  get "up" => "rails/health#show", as: :rails_health_check

end
