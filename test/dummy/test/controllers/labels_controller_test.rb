require 'test_helper'

class LabelsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, post_id: 1
    assert_response :success
  end

  test "should get show" do
    get :show, post_id: 1, id: 1
    assert_response :success
    assert_equal('user1', JSON.parse(response.body)['user'])
  end
end
