# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bing/ads/version"

Gem::Specification.new do |spec|
  spec.name          = "bing-ads"
  spec.version       = Bing::Ads::VERSION
  spec.authors       = ["oss92"]
  spec.email         = ["mohamed.o.alnagdy@gmail.com"]

  spec.summary       = %q{Enhances the experience of developing Bing Ads applications with Ruby}
  spec.description   = %q{A Ruby client for Bing Ads API that includes a proxy to all Bing Ads API web services and abstracts low level details of authentication with OAuth2.}
  spec.homepage      = "https://github.com/oss92/bing-ads"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'savon', '~> 2.11.1'
  spec.add_dependency 'activesupport', '~> 5.0'
  spec.add_dependency 'persey', '>= 0.0.11'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
