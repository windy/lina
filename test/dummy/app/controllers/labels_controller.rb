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
end
