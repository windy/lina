require_dependency 'lina/base_controller'

module Lina
  class SchemaController < BaseController
    def index
      if ! controller = user_api_controllers.find { |c| c == params[:schema_controller] }
        raise "#{t('lina.controller')} #{params[:schema_controller]} #{t('lina.notfound')}"
      end

      action = params[:schema_action].to_sym
      if ! @schema = str2controller(controller)._actions[action]
        raise "#{t('lina.action')} #{action} #{t('lina.notfound')}"
      end
    end
  end
end
