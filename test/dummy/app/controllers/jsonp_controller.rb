class JsonpController < Lina::ApplicationController
  skip_before_action :verify_authenticity_token
  # def index
  define_action :index, {
    name: 'jsonp test',
    description: '',
    params: {
      type: 'object',
      properties: {
      }
    },
    return: {
      type: 'string',
      description: 'callback test'
    }
  } do
    render json: {}, callback: true
  end
end
