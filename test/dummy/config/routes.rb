Rails.application.routes.draw do

  get 'arrays/index'

  namespace :admin do
    get 'posts/index'
  end

  mount Lina::Engine => "/lina"

  resources :posts, only: [:index, :show, :update] do
    resources :labels, only: [:index]
  end
  resources :desks, only: [:index, :show, :update] do
    collection do
      get :default_value
    end
  end
  root 'posts#index'
end
