class NestedObjectsController < Lina::ApplicationController
  # def index
  define_action :index, {
    name: 'index',
    description: '',
    params: {
      type: 'object',
      properties: {
        object: {
          type: 'object',
          properties: {
            name: {
              type: 'string',
            }
          }
        }
      }
    },
    return: {
    }
  } do
    # write code here, It's the same as before
  end
end
