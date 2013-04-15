# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ifuture/version'

Gem::Specification.new do |gem|
  gem.name          = 'ifuture'
  gem.version       = IFuture::VERSION
  gem.authors       = ['Shannon Skipper']
  gem.email         = ['shannonskipper@gmail.com']
  gem.description   = %q{Futures Implemented on Fork}
  gem.summary       = %q{Futures implemented on top of IChannel for easy Forking.}
  gem.homepage      = 'https://github.com/Havenwood'

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ['lib']
  
  gem.add_development_dependency 'ichannel', '~> 5.2.0'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rake'
  
  gem.add_runtime_dependency 'ichannel', '~> 5.2.0'
  
  gem.signing_key = '/Users/shannonskipper/.gem/private/gem-private_key.pem'
  gem.cert_chain  = ['/Users/shannonskipper/.gem/private/gem-public_cert.pem']
end
