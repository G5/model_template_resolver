$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "template_resolver/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "template_resolver-rails"
  s.version     = TemplateResolver::VERSION
  s.authors     = ["G5", "Ramon Tayag"]
  s.email       = ["lateam@getg5.com","ramon.tayag@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of TemplateResolver."
  s.description = "TODO: Description of TemplateResolver."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
