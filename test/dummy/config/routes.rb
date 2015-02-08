Rails.application.routes.draw do

  namespace :admin do
  get 'posts/index'
  end

  mount Lina::Engine => "/lina"

  resources :posts, only: [:index] do
    resources :labels, only: [:index]
  end
  resources :desks, only: [:index, :show]
  root 'posts#index'
end
