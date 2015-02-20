class PostsController < Lina::ApplicationController
  define_action :index, {
    name: 'Posts Index',
    params: {
    },
    return: {
    }
  } do
    render json: { name: 'post name1' }
  end

  define_action :show, {
    name: 'show a post by ID',
    params: {
      required: [ :id ],
      properties: {
        id: {
          type: 'integer'
        },
      }
    },
    return: {
    }
  } do
    render json: { name: "post with: #{params[:id]}" }
  end

  define_action :update, {
    name: 'update the post by ID',
    params: {
      required: [ :id ],
      properties: {
        id: {
          type: 'integer'
        },
      }
    },
    return: {
    }
  } do
    render json: { id: params[:id] }
  end
end
