# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'sidekiq-global_id'
  spec.version       = '0.2.0'
  spec.authors       = ['Tema Bolshakov']
  spec.email         = ['abolshakov@spbtv.com']

  spec.summary       = 'Sidekiq and GlobalId integration'
  spec.description   = 'Provides Sidekiq middleware to serialize ActiveRecord objects with GlobalId'
  spec.homepage      = 'https://github.com/bolshakov/sidekiq-global_id'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'sidekiq', '>= 4.0'
  spec.add_runtime_dependency 'globalid', '>= 0.3.7', '< 0.5'
  spec.add_runtime_dependency 'activejob', '>= 4.2.5'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'spbtv_code_style', '1.4.1'
  spec.add_development_dependency 'temping', '~> 3.7.1'
  spec.add_development_dependency 'sqlite3', '~> 1.3.10'
  spec.add_development_dependency 'rspec-sidekiq', '~> 2.2'
end
