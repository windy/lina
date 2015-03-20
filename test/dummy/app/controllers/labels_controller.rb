class LabelsController < PostsController
  define_action :index, {
    name: 'labels index',
    params: {
    },
    return: {
    }
  } do
    render json: []
  end

  define_action :show, {
    name: 'label id show',
    params: {
      type: 'object',
      properties: {
        id: { type: 'string' }
      }
    },
    return: {
    }
  } do
    render json: { user: current_user }
    return
  end
end
