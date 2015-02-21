require 'test_helper'

module Lina
  class SchemaControllerTest < ActionController::TestCase
    test "schema api" do
      skip "next"
    end

    test "Lina::ApiSpecError" do
      a = -> {
        class WrongAPiSpecController < Lina::ApplicationController
          define_action :index, { params: 'spec erorr' } do
          end
        end
      }

      assert_raise(Lina::ApiSpecError, &a)
    end

    test "Lina::ApiSpecParamsError" do
      a = -> {
        class WrongAPiSpecController < Lina::ApplicationController
          define_action :index, {
            name: 'index',
            params: { type: 'object1' },
            return: {}
          } do
          end
        end
      }

      assert_raise(Lina::ApiSpecParamsError, &a)
    end

    test "Lina::ApiSpecReturnError" do
      a = -> {
        class WrongAPiSpecController < Lina::ApplicationController
          define_action :index, {
            name: 'index',
            params: {},
            return: { type: 'object1' }
          } do
          end
        end
      }

      assert_raise(Lina::ApiSpecReturnError, &a)
    end
  end
end
