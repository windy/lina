Rails.application.routes.draw do

  namespace :admin do
    get 'posts/index'
  end

  mount Lina::Engine => '/lina'

  resources :arrays, only: [:index] do
    collection do
      get :string
      get :boolean
      get :null
      get :array_object
      get :array_object_nested_array
    end
  end

  resources :posts, only: [:index, :show, :update] do
    resources :labels, only: [:index, :show]
  end
  resources :desks, only: [:index, :show, :update] do
    collection do
      get :default_value
    end
  end
  root 'posts#index'
end
