Rails.application.routes.draw do
  devise_for :users
  resources :houses, only: [:new, :create, :edit, :update]
  resources :devices do
    resources :types, only: :index
  end
  resources :actions, only: :index
  resources :brands, only: :index

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
