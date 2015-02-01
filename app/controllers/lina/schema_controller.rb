require_dependency "lina/base_controller"

module Lina
  class SchemaController < BaseController
    def index
      Rails.application.eager_load!
      @trees = Lina::ApplicationController.subclasses
      controller = ::Kernel.const_get(params[:schema_controller].to_s.camelize + 'Controller')
      action = params[:schema_action].to_sym
      @schema = @trees.find { |i| i == controller}._actions[action]
    end
  end
end
