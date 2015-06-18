# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kazakhstan_national_bank/version'

Gem::Specification.new do |spec|
  spec.name          = 'kazakhstan_national_bank'
  spec.version       = KazakhstanNationalBank::VERSION
  spec.authors       = ['Ilya Hrytsuk']
  spec.email         = ['bypotatoes@gmail.com']
  spec.summary       = 'Access to Kazakhstan National Bank currency exchange rates.'
  spec.description   = 'KazakhstanNationalBank extends Money::Bank::VariableExchange and gives you access to the Kazakhstan National Bank currency exchange rates.'
  spec.homepage      = 'https://github.com/rubyroidlabs/kazakhstan_national_bank'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
