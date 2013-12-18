# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middlesite/version'

Gem::Specification.new do |spec|
  spec.name          = "middlesite"
  spec.version       = Middlesite::VERSION
  spec.authors       = ["franklin"]
  spec.email         = ["franklin@weareinteractive.com"]
  spec.description   = %q{Gem containing tasks to build, release and deploy your Middleman site.}
  spec.summary       = %q{Tasks to manage Middleman sites.}
  spec.homepage      = "https://github.com/weareinteractive/gem-middlesite"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "git"
  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "semver"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler"
end
