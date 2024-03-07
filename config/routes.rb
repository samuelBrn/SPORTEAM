Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get '/design', to: "pages#design"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "up" => "rails/health#show", as: :rails_health_check
  get 'dashboard', to: 'pages#dashboard'
  patch 'update_profile', to: 'pages#update_profile' # Ajout de la route pour la mise à jour du profil
  patch 'profile', to: 'pages#update_profile', as: :user_profile


  resources :events do
    resources :participations, only: %i[new create]
    post 'participate', to: 'participations#instant_create', on: :member
  end

  resources :participations, only: :destroy

  resources :categories, only: [] do
    resources :favourites, only: %i[create]
  end

  resources :favourites, only: %i[destroy]
end
