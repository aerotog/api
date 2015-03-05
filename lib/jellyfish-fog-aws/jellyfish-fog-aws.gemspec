# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jellyfish/fog/aws/version'

Gem::Specification.new do |spec|
  spec.name          = "jellyfish-fog-aws"
  spec.version       = Jellyfish::Fog::AWS::VERSION
  spec.authors       = ["Caleb Thompson"]
  spec.email         = ["caleb@calebthompson.io"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_dependency "railties"
  spec.add_dependency "fog"
end
