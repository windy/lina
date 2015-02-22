class ArraysController < Lina::ApplicationController
  # def index
  define_action :index, {
    name: 'index',
    description: '',
    params: {
      type: 'object',
      required: [:name],
      properties: {
        name: {
          type: 'string',
          description: '名称',
        }
      }
    },
    return: {
      oneOf: [
        { "$ref"=> "#/definitions/error" },
        { "$ref"=> "#/definitions/right" },
      ],
      definitions: {
        error: {
          type: 'string',
        },
        right: {
          type: 'array',
          items: {
            type: 'string',
          }
        }
      }
    }
  } do
    if params[:name] == 'string'
      render json: 'string'
    elsif params[:name] == 'array'
      render json: [ 'item' ]
    else
      render json: [ { wrong: 'wrong item' } ]
    end
  end
end
