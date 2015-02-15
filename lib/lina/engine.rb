module Lina
  class Engine < ::Rails::Engine
    isolate_namespace Lina
  end

  def self.setup
    yield self
  end

  mattr_accessor :params_check
  @@params_check = true

  mattr_accessor :params_json_schema_version
  @@params_json_schema_version = :v4

  mattr_accessor :return_check
  @@return_check = true

  mattr_accessor :return_json_schema_version
  @@return_json_schema_version = :v4
end
