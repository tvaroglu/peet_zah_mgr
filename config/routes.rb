Rails.application.routes.draw do
  resources :pizzas, only: %i[ index new create edit update destroy ]
  resources :toppings, only: %i[ index new create edit update destroy ]

  # Root path placeholder (show list of pizzas by default)
  root "pizzas#index"
end
