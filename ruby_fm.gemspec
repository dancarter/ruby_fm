# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_fm/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_fm"
  spec.version       = RubyFm::VERSION
  spec.authors       = ["Daniel Carter"]
  spec.email         = ["dnyecarter@gmail.com"]
  spec.description   = %q{Wrapper for using the Last FM API}
  spec.summary       = %q{Wrapper for using the Last FM API using Faraday, VCS, and RSpec}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "multi_json"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "pry"
end
