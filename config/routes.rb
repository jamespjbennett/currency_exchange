Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'fallback#redirect'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      root 'currencies#index'
      resources :currencies
      resources :quotations
      resources :exchange_rates
      resources :orders
      resources :users
    end
  end
end
