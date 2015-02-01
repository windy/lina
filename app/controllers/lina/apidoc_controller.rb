require_dependency "lina/application_controller"

module Lina
  class ApidocController < ApplicationController
    def index
      Rails.application.eager_load!
      @trees = Lina::ApplicationController.subclasses - [self.class]
      all_routes = Rails.application.routes.routes
      inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
      api_routes = []
      @trees.each do |controller|
        controller = controller.to_s.underscore.sub(/_controller$/, '')
        api_routes += inspector.send(:filter_routes, controller)
      end
      #binding.pry
      @routes = inspector.send(:collect_routes, api_routes)
    end
  end
end
