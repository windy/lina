require 'lina/utils'
require 'lina/tree'
require "lina/engine"
require 'json-schema'
require 'lina/schema'
require 'jquery-rails'
require 'bootstrap-sass'

require 'lina/rails/router'
require 'lina/generators/generators'

module Lina
  def self.setup
    yield self
  end

  mattr_accessor :arg
  @@arg = 'default'
end
