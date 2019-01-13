# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "RayTracer"
  spec.version       = '1.0'
  spec.authors       = ["Paul Gaffney"]
  spec.email         = ["pgaffney2000@gmail.com"]
  spec.summary       = %q{Implementation of a RayTracer}
  spec.description   = %q{The RayTracer Challenge b5.0.}
  spec.homepage      = "http://gaffney.io/raytracer/"
  spec.license       = "MIT"

  spec.files         = ['lib/RayTracer.rb']
  spec.executables   = ['bin/RayTracer']
  spec.test_files    = ['tests/test_RayTracer.rb']
  spec.require_paths = ["lib"]
end
