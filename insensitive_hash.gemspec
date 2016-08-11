# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'insensitive_hash/version'

Gem::Specification.new do |spec|
  spec.name          = "insensitive_hash"
  spec.version       = InsensitiveHash::VERSION
  spec.authors       = ["Sam Boylett"]
  spec.email         = ["sam.boylett@alumni.york.ac.uk"]

  spec.summary       = %q{A hash where :foo, 'foo', :Foo and 'FOO' are all equal keys}
  spec.homepage      = "https://github.com/automeow/insensitive_hash"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
