require 'test_helper'

module Lina
  class TreeTest < ActiveSupport::TestCase
    test ".paths_to_tree" do
      routes = [
        { path: '/admin/posts', verb: 'GET' },
        { path: '/admin/labels', verb: 'GET' },
        { path: '/posts', verb: 'GET' },
      ]
      tree = Lina::Tree.new(routes)
      assert_equal 3, tree.size
    end
  end
end
