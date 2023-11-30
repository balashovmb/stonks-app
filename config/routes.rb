Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :stocks, only: [:index] do
    get :trading, on: :collection
    get :daily_quotes
    get :subscribe_on_quotes, on: :collection
  end

  resources :deals, only: [:create, :show, :index]

  resource :portfolio, only: :show do
    patch :get_or_add_cash
  end

  resources :favorite_stocks, only: [:create, :destroy]

  root to: "stocks#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
