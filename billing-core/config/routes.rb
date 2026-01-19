require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'billing/run-cycle', to: 'billing#run_cycle'
      post '/run/invoice-job', to: 'jobs#run_cycle'
      resources :clients, only: [:create, :show]
      resources :products, only: [:create, :show]
      resources :subscriptions, only: [:create] do
        member do
          patch :cancel
        end
      end
      resources :invoices, only: [:show, :index]
      post 'webhooks/payment', to: 'webhooks#payment'
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
