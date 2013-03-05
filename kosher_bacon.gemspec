# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kosher_bacon/version'

Gem::Specification.new do |spec|
  spec.name          = "kosher_bacon"
  spec.version       = KosherBacon::VERSION
  spec.authors       = ["Dave Lee"]
  spec.email         = ["dave@kastiglione.com"]
  spec.summary       = '{MiniTest,Test}::Unit adaptor for RubyMotion'
  spec.description   = <<-DESC
kosher_bacon is an adaptor that converts test written for MiniTest::Unit into
specs that can be run by MacBacon.
  DESC
  spec.homepage      = "https://github.com/kastiglione/#{spec.name}"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
