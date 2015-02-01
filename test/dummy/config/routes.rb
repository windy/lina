Rails.application.routes.draw do

  mount Lina::Engine => "/lina"

  resources :posts
  root 'posts#index'
end
