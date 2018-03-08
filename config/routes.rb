Rails.application.routes.draw do

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  # authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  # end

  devise_for :users
  resources :houses, only: [:new, :create, :edit, :update]
  resources :devices do
    resources :types, only: :index
  end
  resources :actions, only: :index
  resources :brands, only: :index
  resources :consumptions , only: :show

  root to: 'pages#home'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
