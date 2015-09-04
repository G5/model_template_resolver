$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "model_template_resolver/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "model_template_resolver"
  s.version     = ModelTemplateResolver::VERSION
  s.authors     = ["G5", "Ramon Tayag"]
  s.email       = ["lateam@getg5.com","ramon.tayag@gmail.com"]
  s.homepage    = "https://github.com/g5/model_template_resolver"
  s.summary     = "Find the template of a model like template inheritance but without relying on controllers"
  s.description = "Find the template of a model like template inheritance but without relying on controllers"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 3.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
