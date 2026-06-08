Rails.application.routes.draw do
  get "searches/index"
  resource :session
  resources :passwords, param: :token

  root "homes#top"
  get "about" => "homes#about"
  get "mypage" => "users#mypage"
  get "search" => "searches#index"

  resources :users, only: [:index, :show,:new, :create, :edit, :update, :destroy]

  resources :anime_reviews do
    resources :comments, only: [:create, :destroy]
  end

  namespace :admin do
    get "users/index"
    get "users/show"
    get    "sign_in",  to: "sessions#new"
    post   "sign_in",  to: "sessions#create"
    delete "sign_out", to: "sessions#destroy"

    resources :users, only: [:index, :show, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
