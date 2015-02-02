require 'test_helper'

class LabelsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, post_id: 1
    assert_response :success
  end

end
