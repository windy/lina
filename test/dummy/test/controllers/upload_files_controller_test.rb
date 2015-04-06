require 'test_helper'

class UploadFilesControllerTest < ActionController::TestCase
  test "upload files create" do
    post :create, { Filedata: Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/supports/', 'test.png'), 'image/png') }
    assert_response 200, response
  end
end
