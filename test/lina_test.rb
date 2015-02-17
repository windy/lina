require 'test_helper'

class LinaTest < ActiveSupport::TestCase
  test ".version" do
    assert(Lina::VERSION)
  end
end
