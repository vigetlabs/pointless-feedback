$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pointless_feedback/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pointless_feedback"
  s.version     = PointlessFeedback::VERSION
  s.authors     = ["Zachary Porter"]
  s.email       = ["developers@viget.com"]
  s.homepage    = "https://github.com/vigetlabs/pointless-feedback"
  s.summary     = "Simple Rails Engine to allow users to submit feedback"
  s.description = "Simple Rails Engine to allow users to submit feedback"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "typhoeus", "~> 0.7"

  s.add_development_dependency "sqlite3",            "~> 0"
  s.add_development_dependency "capybara",           "~> 0"
  s.add_development_dependency "factory_girl_rails", "~> 0"
  s.add_development_dependency "launchy",            "~> 0"
end
