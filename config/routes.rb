Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'home/index'
  root 'home#index'

  resources :books
  resources :user_addresses, only: %i[create update]
  resources :users, only: %i[update edit destroy show]
  resources :reviews, only: :create
  resources :orders do
    resources :line_items
  end
  resources :coupons, only: :create
  resources :quick_registrations
end
