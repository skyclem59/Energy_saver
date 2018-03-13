Rails.application.routes.draw do
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  # authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  # end
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

    scope '(:locale)', locale: /fr/ do
    resources :houses, only: [:show, :new, :create, :edit, :update]
    resources :devices do
      resources :types, only: :index
    end
    resources :actions, only: :index
    resources :brands, only: :index
    resources :consumptions , only: :show

    root to: 'pages#home'
  end
end
