Rails.application.routes.draw do
  resources :lists do
    resources :categories, only: %i[new create edit update destroy]
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
end
