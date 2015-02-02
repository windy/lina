require 'test_helper'
require 'pp'

module Lina
  class UtilsTest < ActiveSupport::TestCase
    test ".paths_insert_tree" do
      tree = []
      paths = [ 'admin', 'posts' ]
      Lina::Utils.paths_insert_tree(paths, tree)
      assert_equal([ { 'admin' => [ 'posts' => [] ] } ], tree)
    end

    test ".routes_to_tree" do
      routes = [
        { path: '/admin/posts' },
        { path: '/admin/labels' },
        { path: '/posts' },
      ]
      pp Lina::Utils.routes_to_tree(routes)
    end
  end
end
