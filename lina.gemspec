$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lina/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lina"
  s.version     = Lina::VERSION
  s.authors     = ["Li Yafei"]
  s.email       = ["lyfi2003@gmail.com"]
  s.homepage    = "https://github.com/windy/lina"
  s.summary     = "a charming self-documenting api provider based on Ruby on Rails"
  s.description = "charming, self-documenting, json schema, based on Ruby on Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "pry-byebug"
end
