Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'home/index'
  root 'home#index'

  resources :books
  resources :addresses, only: [:create, :update]
  resources :users, only: %i[update edit destroy show]
end
