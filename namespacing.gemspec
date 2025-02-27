# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'namespacing/version'

Gem::Specification.new do |spec|
  spec.name          = "namespacing"
  spec.version       = Namespacing::VERSION
  spec.authors       = ["Justin Herrick"]
  spec.email         = ["justin@justinherrick.com"]
  spec.summary       = %q{Adds Clojure like Namespacing to Ruby.}
  spec.description   = %q{Allows you to succintly define deeply nested modules.}
  spec.homepage      = "https://github.com/jah2488/namespacing"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.10"
end
