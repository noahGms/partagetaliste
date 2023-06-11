Rails.application.routes.draw do
  devise_for :users

  resources :lists do
    resources :categories, only: [:new, :create, :edit, :update, :destroy]
  end

  root "home#index"
end
