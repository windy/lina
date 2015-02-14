module Lina
  class Schema
    def self.argument
      {
        "type" => "object",
        "properties" => {
          'required' => [ 'name', 'params', 'return'],
          "name" => {"type" => "string", "description" => "name" },
          "params" => {
            "type" => "object",
          },
          "return" => {
            "type" => "object",
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
end
