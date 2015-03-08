require_dependency 'lina/base_controller'

module Lina
  class ApidocController < BaseController
    def index
      all_routes = Rails.application.routes.routes
      inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)

      # 过滤出所有 API 相关的路由
      api_routes = []
      @user_api_controllers = user_api_controllers
      @user_api_controllers.each do |controller|
        api_routes += inspector.send(:filter_routes, controller)
      end

      @routes = inspector.send(:collect_routes, api_routes)
      # add schema info to route
      @routes.select! do |route|
        controller, action = route[:reqs].split('#')
        route[:path].gsub!('(.:format)', '')
        route[:schema] = str2controller(controller).action_schema(action)
        str2controller(controller).action_methods.include?(action)
      end
      @_tree = Lina::Tree.new(@routes)
      @tree = @_tree.to_tree
      respond_to do |format|
        format.html
        format.json { render json: @tree }
      end
    end
  end
end
