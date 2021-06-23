Rails.application.routes.draw do
  devise_for :users

  resources :stocks, only: [:index] do
    get :get_quote, on: :collection
  end

  resources :deals, only: [:create, :show]

  resource :portfolio, only: :show do
    patch :change_cash_volume
  end

  root to: "stocks#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
