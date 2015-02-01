class DesksController < Lina::ApplicationController
  define_action :index, {
    name: '显示所有桌子',
    params: {
      required: [ 'id' ],
      id: {
        type: 'string',
      }
    },
    return: {
      required: [ 'id' ],
      id: {
        type: 'string'
      }
    }
  } do
    render json: { name: 'desk name', id: '123' }
  end
end
