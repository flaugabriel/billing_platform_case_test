Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :clients, only: [:create, :show]
      resources :subscriptions, only: [:create] do
        member do
          patch :cancel
        end
      end
      resources :invoices, only: [:show]
      post 'webhooks/payment', to: 'webhooks#payment'
    end
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
