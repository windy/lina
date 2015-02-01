class PostsController < Lina::ApplicationController
  define_action :index, {
    name: 'hello world',
    params: {
    },
    return: {
    }
  } do
    render json: { name: 'post name1' }
  end
end
