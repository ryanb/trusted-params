Gem::Specification.new do |s|
  s.name        = "trusted_params"
  s.version     = "1.0.0"
  s.author      = "Ryan Bates"
  s.email       = "ryan@railscasts.com"
  s.homepage    = "http://github.com/ryanb/trusted-params"
  s.summary     = "Rails plugin which adds a convenient way to override attr_accessible protection."

  s.files        = Dir["{lib,spec,rails}/**/*", "[A-Z]*"]
  s.require_path = "lib"

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end