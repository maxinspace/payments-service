# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :merchants
  resources :transactions, only: [:index, :show]
  mount Sidekiq::Web => "/sidekiq"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes
  get "welcome/index"
  root "welcome#index"

  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#login'

      resources :users
      resources :transactions, only: [:index, :create]
    end
  end
end
