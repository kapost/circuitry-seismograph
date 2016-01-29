# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'circuitry/seismograph/version'

Gem::Specification.new do |spec|
  spec.name          = 'circuitry-seismograph'
  spec.version       = Circuitry::Seismograph::VERSION
  spec.authors       = ['Matt Huggins']
  spec.email         = ['matt.huggins@gmail.com']

  spec.summary       = %q{Circuitry middleware for DataDog tracking}
  spec.description   = %q{Adds circuitry middleware for tracking message processing to DataDog.}
  spec.homepage      = 'https://github.com/kapost/circuitry-seismograph'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'circuitry', '~> 2.1.0'
  spec.add_dependency 'seismograph', '~> 0.3.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.2.0'
end
