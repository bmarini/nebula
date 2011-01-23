# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nebula/version"

Gem::Specification.new do |s|
  s.name        = "nebula"
  s.version     = Nebula::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Marini"]
  s.email       = ["bmarini@gmail.com"]
  s.homepage    = "http://github.com/bmarini/nebula"
  s.summary     = %q{Tool for building server clusters with chef and fog}
  s.description = %q{Tool for building server clusters with chef and fog}

  s.rubyforge_project = "nebula"

  s.add_dependency "fog", "~> 0.4.1"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
