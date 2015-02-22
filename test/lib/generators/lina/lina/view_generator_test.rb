require 'test_helper'
require 'generators/lina/view/view_generator'

module Lina
  class Lina::ViewGeneratorTest < Rails::Generators::TestCase
    tests Lina::ViewGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    test "generator runs without errors" do
      assert_nothing_raised do
        run_generator ["index show"]
      end
    end
  end
end
