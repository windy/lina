require_dependency "lina/base_controller"

module Lina
  class ApidocController < BaseController
    def index
      all_routes = Rails.application.routes.routes
      inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)

      # 过滤出所有 API 相关的路由
      api_routes = []
      @user_api_controllers = user_api_controllers
      @api_controllors = all_subclasses(Lina::ApplicationController, false)
      @user_api_controllers.each do |controller|
        api_routes += inspector.send(:filter_routes, controller)
      end

      @routes = inspector.send(:collect_routes, api_routes)
      @tree = Lina::Tree.parse(@routes)
    end
  end
end
