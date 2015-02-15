module Lina
  class ApplicationController < ActionController::Base

    def send_action(method_name, *args)
      block = self.class.action_block(method_name)
      schema = self.class.action_schema(method_name)
      if block
        logger.info("schema: #{schema}")
        JSON::Validator.validate!(schema[:params], params)
        ret = self.instance_exec(*args, &block)
        JSON::Validator.validate!(schema[:return], ret && ret[0])
        default_render unless performed?
        ret
      else
        super
      end
    end

    before_filter :default_format_json

    private
    def default_format_json
      request.format = "json" unless params[:format]
    end

    class <<self
      _actions = {}
      def define_action(name, schema={}, &block)
        if ! JSON::Validator.validate(Lina::Schema.argument, schema)
          raise "API 声明有错误"
        end
        _actions[name] = { schema: schema, block: block }
      end

      def action_methods
        @@action_methods = begin
          methods = (api_actions + public_instance_methods(true) -
            internal_methods +
            public_instance_methods(false)).uniq.map { |x| x.to_s } -
            hidden_actions.to_a
          Set.new(methods.reject { |method| method =~ /_one_time_conditions/ })
        end
      end

      # 所有支持的 API 列表
      def api_actions
        _actions.keys
      end

      # 返回所有实例
      def api_action_instances
        _actions
      end

      def action_schema(name)
        _actions[name.to_sym] && _actions[name.to_sym][:schema]
      end

      def action_block(name)
        _actions[name.to_sym] && _actions[name.to_sym][:block]
      end

      def _actions
        @actions ||= {}
      end
    end
  end
end
