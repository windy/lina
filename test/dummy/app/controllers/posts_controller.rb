class PostsController < Lina::ApplicationController
  define_action :index, {
    hello: 'world'
  } do
    render json: { name: 'post name' }
  end
end
