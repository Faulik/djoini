# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'djoini/version'

Gem::Specification.new do |spec|
  spec.name          = 'djoini'
  spec.version       = Djoini::VERSION
  spec.authors       = ['faul']
  spec.email         = ['faullik@gmail.com']
  spec.files         = Dir['{bin,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  spec.test_files    = Dir['spec/**/*']

  spec.summary       = 'Implimentation of ActiveModel pattern and a fixture loader'
  # spec.homepage      = "Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  spec.add_runtime_dependency 'pg', '~> 0.18.3'
  spec.add_runtime_dependency 'iniparse', '~> 1.4.1'
  spec.add_runtime_dependency 'multi_json', '~> 1.11.2'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3.0'
  spec.add_development_dependency 'pry', '~> 0.10.2'
end
