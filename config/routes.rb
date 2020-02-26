Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :books
  get '/books/', to: 'books#index', as: 'back'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
