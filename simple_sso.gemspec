$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_sso/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_sso"
  s.version     = SimpleSso::VERSION
  s.authors     = [""]
  s.email       = [""]
  # s.homepage    = "TODO"
  # s.summary     = "TODO: Summary of SimpleSso."
  # s.description = "TODO: Description of SimpleSso."
  s.homepage    = "https://adwd.com"
  s.summary     = "Summary of SimpleSso."
  s.description = "Description of SimpleSso."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"
  s.add_dependency "byebug"

  s.add_development_dependency "sqlite3"
end
