# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'healthcheck/version'

Gem::Specification.new do |spec|
  spec.name          = "healthcheck"
  spec.version       = Healthcheck::VERSION
  spec.authors       = ["fillman"]
  spec.email         = ["fila.luka@gmail.com"]
  spec.description   = %q{A small tool to ping your services}
  spec.summary       = %q{Imagine you have a tons of services running somewhere on heroku or else where. And clamp!
                          One got down, you try to find which and its a time consuming thing. This tool will register
                          your apps and ping them any time you like }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "escort"
  spec.add_dependency "terminal-table"
  spec.add_dependency "progress_bar"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
end
