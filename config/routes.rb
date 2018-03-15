Rails.application.routes.draw do
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  # authenticate :user, lambda { |u| u.admin } do
  mount Sidekiq::Web => '/sidekiq'
  # end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get '/nest/callback', to: 'nest#create', as: :nest
  get  '/auth/smappee', to: 'smappee#new', as: :new_smappee
  post '/auth/smappee/callback', to: 'smappee#create', as: :smappee
  get '/auth/philips', to: 'philips#new', as: :new_philips
  post '/auth/philips/', to: 'philips#create', as: :philips

  resources :houses, only: [:show, :new, :create, :edit, :update]
  resources :devices do
    resources :types, only: :index
  end
  resources :actions, only: :index
  resources :brands, only: :index
  resources :consumptions , only: :show

  root to: 'pages#home'
end
