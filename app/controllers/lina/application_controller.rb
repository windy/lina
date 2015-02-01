module Lina
  class ApplicationController < ActionController::Base

    def send_action(method_name, *args)
      block = self.class.action_block(method_name)
      schema = self.class.action_schema(method_name)
      if block
        logger.info("schema: #{schema}")
        ret = self.instance_exec(*args, &block)
        default_render unless performed?
        ret
      else
        super
      end
    end

    class <<self
      @@actions = {}
      def define_action(name, schema={}, &block)
        @@actions[name] = { schema: schema, block: block }
      end

      def action_methods
        @@action_methods ||= begin
          methods = (api_actions + public_instance_methods(true) -
            internal_methods +
            public_instance_methods(false)).uniq.map { |x| x.to_s } -
            hidden_actions.to_a
          Set.new(methods.reject { |method| method =~ /_one_time_conditions/ })
        end
      end

      # 所有支持的 API 列表
      def api_actions
        @@actions.keys
      end

      # 返回所有实例
      def api_action_instances
        @@actions
      end

      def action_schema(name)
        @@actions[name.to_sym] && @@actions[name.to_sym][:schema]
      end

      def action_block(name)
        @@actions[name.to_sym] && @@actions[name.to_sym][:block]
      end
    end
  end
end
