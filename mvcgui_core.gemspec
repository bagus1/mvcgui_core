# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mvcgui_core/version'

Gem::Specification.new do |spec|
  spec.name          = "mvcgui_core"
  spec.version       = MvcguiCore::VERSION
  spec.authors       = ["Bagus"]
  spec.email         = ["bagus1@github.com"]
  spec.summary       = %q{Provides core MVCGUI functionality.}
  spec.description   = %q{This will provide a number of tables that store properties for core things like apps and fields and views. It provides models and controllers for them.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "simplecov", '~> 0.7.1'
  spec.add_development_dependency 'spork-rails'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'pry-debugger'
  spec.add_development_dependency 'pry-rails'
end
