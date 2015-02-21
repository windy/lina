require 'test_helper'

class DesksControllerTest < ActionController::TestCase
  test "#index" do
    get :index
    assert_equal [ {'name'=> 'name1'}, {'name'=> 'name2'} ], JSON.parse(response.body)
  end

  test "#show validate failed" do
    assert_raise(Lina::ParamsCheckError) { get :show, id: 1, filter_name: 'x' * 6 }
  end

  test "#update return validate failed" do
    assert_raise(Lina::ReturnCheckError) { put :update, id: 1 }
  end

  test "default value" do
    get :default_value
    assert_equal( 'default', assigns(:filter) )

    get :default_value, filter: '1'
    assert_equal( '1', assigns(:filter) )
  end

end
