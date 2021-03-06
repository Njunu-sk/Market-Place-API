Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :orders
      resources :users
      resources :tokens, only: [:create]
      resources :products
    end
  end
end
