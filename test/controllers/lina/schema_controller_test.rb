require 'test_helper'

module Lina
  class SchemaControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
