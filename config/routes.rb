Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  get 'dashboard', to: 'pages#dashboard'

  resources :events, only: %i[create new index show] do
    resources :participations, only: %i[new create]
    post 'participate', to: 'participations#instant_create', on: :member
  end

    end


  # Defines the root path route ("/")
  # root "posts#index"
