# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-qq-oauth2/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-qq-oauth2"
  gem.version       = Omniauth::Qq::Oauth2::VERSION
  gem.authors       = ["inetufo"]
  gem.email         = ["inetufo@163.com"]
  gem.description   = %q{OmniAuth2 strategies for TQQ and QQ Connect}
  gem.summary       = %q{OmniAuth2 strategies for TQQ and QQ Connect}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'omniauth', '~> 1.1.4'
  # gem.add_dependency 'omniauth-oauth2', '~> 1.0'
  gem.add_runtime_dependency 'oauth2', "~> 0.9.1"
  gem.add_dependency 'multi_json'
end
