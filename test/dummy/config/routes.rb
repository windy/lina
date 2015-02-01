Rails.application.routes.draw do

  mount Lina::Engine => "/lina"

  resources :posts, only: [:index]
  resources :desks, only: [:index]
  root 'posts#index'
end
