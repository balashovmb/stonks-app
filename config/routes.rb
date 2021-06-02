Rails.application.routes.draw do
  resources :stocks, only: [:index] do
    get :get_quote, on: :collection
  end

  resources :deals, only: [:create, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
