Lina::Engine.routes.draw do
  get 'schema', to: 'schema#index'

  root "apidoc#index"
end
