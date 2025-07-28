Rails.application.routes.draw do
  resources :pizzas, only: %i[ index new create edit update destroy ]
  resources :toppings, only: %i[ index new create edit update destroy ]

  # User auth:
  resources :users, only: [ :new, :create ]
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Root path login
  root "sessions#new"
end
