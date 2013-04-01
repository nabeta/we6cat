$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "we6cat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "we6cat"
  s.version     = We6cat::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "https://github.com/nabeta/we6cat"
  s.summary     = "We6cat"
  s.description = "an alternative user interface for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "turbolinks"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
