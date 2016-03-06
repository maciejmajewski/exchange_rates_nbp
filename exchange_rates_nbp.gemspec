# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exchange_rates_nbp/version'

Gem::Specification.new do |spec|
  spec.name = 'exchange_rates_nbp'
  spec.version = ExchangeRatesNBP::VERSION
  spec.authors = ['Maciej Majewski']
  spec.email = ['maciej.majewski@gooddesign.pl']

  spec.summary = 'Collects exchange rates from nbp.pl'
  spec.description = 'Exposes simple API and command line tool for fetching '\
                     'exchange rates from nbp.pl'
  spec.homepage = 'http://github.com/maciejmajewski/exchange_rates_nbp'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'http'
  spec.add_runtime_dependency 'oga'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'byebug'
end
