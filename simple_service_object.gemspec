# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_service_object/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_service_object"
  spec.version       = SimpleServiceObject::VERSION
  spec.authors       = ["Fabrizio Monti"]
  spec.email         = ["fabrizio.monti@welaika.com"]

  spec.summary       = "Simple service object implementation."
  spec.description   = <<-TEXT
    It implements the command pattern in a simple way.
  TEXT
  spec.homepage      = "https://github.com/welaika/simple_service_object"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.45"
end
