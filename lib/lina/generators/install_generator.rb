require 'rails/generators'

module Lina
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Create a lina initializer"
      def copy_initializer
        template "lina.rb", "config/initializers/lina.rb"
      end

      def insert_router
        route "api_for '/apidoc'"
      end
    end
  end
end
