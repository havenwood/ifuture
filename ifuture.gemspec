# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ifuture/version'

Gem::Specification.new do |gem|
  gem.name          = 'ifuture'
  gem.version       = IFuture::VERSION
  gem.authors       = ['Shannon Skipper']
  gem.email         = ['shannonskipper@gmail.com']
  gem.description   = %q{Futures over interprocess communication.}
  gem.summary       = %q{A Futures gem for Ruby implemented with IChannel for interprocess communication over a Unix socket or via Redis. Run some code in another process and get the result back later!}
  gem.homepage      = 'https://github.com/havenwood/ifuture#readme'
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ['lib']
  
  gem.add_development_dependency 'ichannel', '~> 8.1.0'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rake'
  
  gem.add_runtime_dependency 'ichannel', '~> 8.1.0'
end
