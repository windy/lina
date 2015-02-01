Rails.application.routes.draw do

  namespace :admin do
  get 'posts/index'
  end

  mount Lina::Engine => "/lina"

  resources :posts, only: [:index]
  resources :desks, only: [:index]
  root 'posts#index'
end
