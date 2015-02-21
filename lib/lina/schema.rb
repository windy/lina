module Lina
  class Schema
    def self.argument
      {
        type: "object",
        required: ['name', 'params', 'return'],
        properties: {
          name: {
            type: "string",
            description: "api name"
          },
          description: {
            type: 'string',
          },
          params: {
            type: "object",
          },
          return: {
            type: "object",
          }
        }
      }
    end

    def self.params_validator(params)
      {
        type: 'object',
        properties: params
      }
    end
  end

  class Validator
    def self.params_check(schema, data)
      return unless Lina.params_check
      begin
        JSON::Validator.validate!(schema, data, insert_defaults: true)
      rescue JSON::Schema::ValidationError => e
        raise Lina::ParamsCheckError, e.message
      end
    end

    def self.schema_check(schema)
      JSON::Validator.fully_validate_schema(schema)
    end

    def self.return_check(schema, data)
      return unless Lina.return_check
      begin
        JSON::Validator.validate!(schema, data)
      rescue JSON::Schema::ValidationError => e
        raise Lina::ReturnCheckError, e.message
      end
    end

    def self.api_spec_check(schema, data)
      begin
        JSON::Validator.validate!(schema, data)
      rescue JSON::Schema::ValidationError => e
        raise Lina::ApiSpecError, e.message
      end

      validator_message = schema_check(data[:params])
      raise Lina::ApiSpecParamsError, validator_message[0] if validator_message.present?

      validator_message = schema_check(data[:return])
      raise Lina::ApiSpecReturnError, validator_message[0] if validator_message.present?
    end
  end # end of class Validator

end
