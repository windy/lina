Rails.application.routes.draw do

  mount Lina::Engine => "/lina"

  resources :posts
  resources :desks
  root 'posts#index'
end
