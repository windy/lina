require 'test_helper'
require 'pp'

module Lina
  class TreeTest < ActiveSupport::TestCase
    test ".paths_to_tree" do
      routes = [
        { path: '/admin/posts', verb: 'GET' },
        { path: '/admin/labels', verb: 'GET' },
        { path: '/posts', verb: 'GET' },
      ]
      tree = Lina::Tree.new(routes)
      #pp tree.paths_to_tree
      pp tree.to_tree
    end
  end
end
