lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/dingtalk/version'

Gem::Specification.new do |s|
  s.name          = 'capistrano-dingtalk'
  s.version       = Capistrano::Dingtalk::VERSION
  s.authors       = ['Dingding Ye']
  s.email         = ['yedingding@gmail.com']
  s.summary       = 'A gem for pushing dingtalk notices via capistrano v3 ' \
                    'deployment'
  s.description   = 'This gem plugs into the deploy task in capistrano to ' \
                    'help provide visibility into when deployments and ' \
                    'rollbacks occured.'
  s.homepage      = 'https://github.com/growingio/capistrano-dingtalk'
  s.license       = 'MIT'

  s.required_ruby_version = '> 1.9'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'capistrano', '~> 3.0'
  s.add_dependency 'httparty', '~> 0.14.0'
  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'webmock'
end
