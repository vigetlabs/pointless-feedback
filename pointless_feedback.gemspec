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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  # s.add_development_dependency "mocha", require: false
  s.add_development_dependency "launchy"
end
