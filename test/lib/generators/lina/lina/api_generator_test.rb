require 'test_helper'
require 'generators/lina/api/api_generator'

module Lina
  class Lina::ApiGeneratorTest < Rails::Generators::TestCase
    tests Lina::Generators::ApiGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
