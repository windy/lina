require_dependency "lina/base_controller"

module Lina
  class ApidocController < BaseController
    def index
      all_routes = Rails.application.routes.routes
      inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)

      # 过滤出所有 API 相关的路由
      api_routes = []
      @tree = user_api_controllers
      @api_controllors = Lina::ApplicationController.subclasses
      @tree.each do |controller|
        api_routes += inspector.send(:filter_routes, controller)
      end

      @routes = inspector.send(:collect_routes, api_routes)
    end
  end
end
