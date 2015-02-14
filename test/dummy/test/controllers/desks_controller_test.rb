require 'test_helper'

class DesksControllerTest < ActionController::TestCase
  test "#index" do
    get :index
    assert_equal [], JSON.parse(response.body)
  end

  test "#show validate failed" do
    assert_raise(JSON::Schema::ValidationError) { get :show, id: 1, filter_name: 'x' * 6 }
  end

  test "#update return validate failed" do
    assert_raise(JSON::Schema::ValidationError) { put :update, id: 1 }
  end

  test "default value" do
    skip "next"
  end

end
