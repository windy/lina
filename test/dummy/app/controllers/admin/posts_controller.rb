class Admin::PostsController < Lina::ApplicationController
  define_action :index, {
    name: 'admin posts index',
    params: {
    },
    return: {
    }
  } do
    render json: { hello: 'world' }
  end
end
