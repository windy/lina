class DesksController < Lina::ApplicationController
  define_action :index, {
    name: '显示所有桌子',
    description: '显示所有桌子的描述',
    params: {
      required: [ 'id' ],
      id: {
        type: 'string',
        description: '桌子ID',
      },
      name: {
        type: 'string',
        description: '名称',
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

  define_action :show, {
    name: '显示指定的桌子',
    params: {
      required: [ 'id' ],
      id: {
        type: 'integer',
        max: 10,
      }
    },
    return: {
      required: [ 'name' ],
      name: {
        type: 'string'
      }
    }
  } do
    render json: { name: params[:id] }
  end
end
