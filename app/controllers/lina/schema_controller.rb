require_dependency "lina/base_controller"

module Lina
  class SchemaController < BaseController
    def index
      if ! controller = user_api_controllers.find { |c| c == params[:schema_controller] }
        raise "Controller #{params[:schema_controller]} 无法找到"
      end

      action = params[:schema_action].to_sym
      if ! @schema = str2controller(controller)._actions[action]
        raise "Action #{action} 无法找到"
      end
    end
  end
end
