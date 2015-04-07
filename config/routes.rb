Rails.application.routes.draw do

  get 'static_pages/home'

  get 'static_pages/help'

  resources :users
  resources :posts
  root 'posts#index'
  
end
