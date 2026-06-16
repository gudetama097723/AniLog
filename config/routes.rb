Rails.application.routes.draw do
  get "searches/index"
  resource :session
  resources :passwords, param: :token

  root "homes#top"
  get "about" => "homes#about"
  get "mypage" => "users#mypage"
  get "search" => "searches#index"

  resources :users, only: [:index, :show,:new, :create, :edit, :update, :destroy] do
    member do
      get :connections
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :anime_reviews do
    resources :comments, only: [:create, :destroy]
  end

  resources :helpful_reviews, only: [:create, :destroy] do
    member do
      patch :toggle_collapsed
    end
  end

  namespace :admin do
    get "genres/index"
    get "comments/index"
    get "anime_reviews/index"
    get "anime_reviews/show"
    get "users/index"
    get "users/show"
    get    "sign_in",  to: "sessions#new"
    post   "sign_in",  to: "sessions#create"
    delete "sign_out", to: "sessions#destroy"

    resources :users, only: [:index, :show, :destroy]
    resources :anime_reviews, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :genres, only: [:index, :create, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
