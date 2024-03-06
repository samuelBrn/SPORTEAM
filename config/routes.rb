Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  get 'dashboard', to: 'pages#dashboard'
  patch 'update_profile', to: 'pages#update_profile' # Ajout de la route pour la mise à jour du profil
  patch 'profile', to: 'pages#update_profile', as: :user_profile


  resources :events, only: %i[create new index show] do
    resources :participations, only: %i[new create]
    post 'participate', to: 'participations#instant_create', on: :member
  end

  resources :categories, only: [] do
    resources :favourites, only: %i[create]
  end

  resources :favourites, only: %i[destroy]
end
