Rails.application.routes.draw do
  root "homes#top"
  get "about" => "homes#about"

  get "up" => "rails/health#show", as: :rails_health_check

end
