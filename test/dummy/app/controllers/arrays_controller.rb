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

  define_action :string, {
    name: 'string return test',
    params: {},
    return: {
      type: 'string',
      description: "return value\nstring",
      minLength: 5,
    }
  } do
    render json: 'hello world'
  end

  define_action :boolean, {
    name: 'boolean return test',
    params: {},
    return: {
      type: 'boolean',
      description: <<-EOF
return value
boolean test
EOF
    }
  } do
    render json: true
  end

  define_action :null, {
    name: 'null return test',
    params: {},
    return: {
      type: 'null',
    }
  } do
    render json: null
  end

  define_action :array_object, {
    name: 'array object return test',
    params: {},
    return: {
      type: 'array',
      items: {
        type: 'object',
        description: 'array item object description',
        required: [ :name ],
        properties: {
          name: {
            type: 'string',
            description: 'array item name description',
            minLength: 5,
          }
        }
      }
    }
  } do
    render json: [ { name: 'hello world' } ]
  end

  define_action :array_object_nested_array, {
    name: 'array object nested array return test',
    params: {},
    return: {
      type: 'array',
      items: {
        type: 'object',
        description: 'array item object description',
        required: [ :name ],
        properties: {
          name: {
            type: 'array',
            description: 'array item name description',
            items: {
              type: 'string',
              minLength: 3,
            }
          },
          content: {
            type: 'string',
            description: 'array item string description',
          },
          zcontent2: {
            type: 'string',
            description: 'array item string description',
          }
        }
      }
    }
  } do
    render json: [ { name: [ 'name' ]  }, { name: [ 'name' ] } ]
  end
end
