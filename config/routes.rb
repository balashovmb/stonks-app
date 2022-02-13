Rails.application.routes.draw do
  devise_for :users

  resources :stocks, only: [:index] do
    get :trading, on: :collection
  end

  resources :deals, only: [:create, :show, :index]

  resource :portfolio, only: :show do
    patch :get_or_add_cash
  end

  resources :favorite_stocks, only: [:create, :destroy]

  root to: "stocks#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
