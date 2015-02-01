module Lina
  class Schema
    def self.argument
      {
        "type" => "object",
        "properties" => {
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
  end
end
