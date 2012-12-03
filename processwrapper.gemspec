# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'processwrapper/version'

Gem::Specification.new do |gem|
  gem.name          = "processwrapper"
  gem.version       = Processwrapper::VERSION
  gem.authors       = ["Chris Beer"]
  gem.email         = ["cabeer@stanford.edu"]
  gem.description   = %q{Wrap a daemon process start/stop for testing}
  gem.summary       = %q{Wrap a daemon process start/stop for testing}
  gem.homepage      = ""
  gem.license       = "Apache 2"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_dependency "childprocess"
  gem.add_dependency "confstruct"
end
