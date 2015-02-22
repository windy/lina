require 'test_helper'

class ArraysControllerTest < ActionController::TestCase
  test "should get index array" do
    get :index, name: 'string'
    assert_response :success

    get :index, name: 'array'
    assert_response :success

    assert_raise(Lina::ReturnCheckError) { get :index, name: 'other' }
  end

end
