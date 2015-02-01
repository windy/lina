module Lina
  class BaseController < ActionController::Base

    private

    # 取得用户使用的所有 API 控制器
    # 避免直接使用 Class 对象, 将它们转化为
    # 字符串形式
    # eg: [ 'posts', 'desks' ]
    def user_api_controllers
      Rails.application.eager_load!
      @user_api_controllers ||= all_subclasses(Lina::ApplicationController)
    end

    def str2controller(klass_str)
      ::Kernel.const_get(klass_str.to_s.camelize + 'Controller')
    end

    def all_subclasses(klass, convert_to_string=true)
      ret = []
      klass.subclasses.each do |k|
        if convert_to_string
          ret << k.to_s.underscore.sub(/_controller$/, '')
        else
          ret << k
        end
        ret += all_subclasses(k, convert_to_string)
      end
      ret
    end
  end
end
