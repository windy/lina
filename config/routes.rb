Lina::Engine.routes.draw do
  get 'schema', to: 'schema#index'
  get 'data', to: 'apidoc#index', format: 'json'

  root "apidoc#index"
end
