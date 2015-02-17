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

  end
end
