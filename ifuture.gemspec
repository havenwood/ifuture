# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ifuture/version'

Gem::Specification.new do |gem|
  gem.name          = 'ifuture'
  gem.version       = IFuture::VERSION
  gem.authors       = ['Shannon Skipper']
  gem.email         = ['shannonskipper@gmail.com']
  gem.description   = %q{Concurrent Futures with Processes}
  gem.summary       = %q{Futures implemented on top of IChannel for interprocess communication.}
  gem.homepage      = 'https://github.com/havenwood#readme'

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ['lib']
  
  gem.add_development_dependency 'ichannel', '~> 7.1.0'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rake'
  
  gem.add_runtime_dependency 'ichannel', '~> 7.1.0'
end
