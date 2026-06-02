Rails.application.routes.draw do

  get "users/new"
  resource :session
  resources :passwords, param: :token
  resources :users, only: [:new, :create]
  resources :anime_reviews

  root "homes#top"
  get "about" => "homes#about"

  get "up" => "rails/health#show", as: :rails_health_check

end
