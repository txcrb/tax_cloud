$:.push File.expand_path("../lib", __FILE__)
require "tax_cloud/version"

Gem::Specification.new do |s|
  s.name        = "tax_cloud"
  s.version     = TaxCloud::VERSION
  s.date        = %q{2011-10-20}
  s.authors     = ["Drew Tempelmeyer"]
  s.email       = ["drewtemp@gmail.com"]
  s.homepage    = "https://github.com/drewtempelmeyer/tax_cloud"
  s.summary     = %q{Calculate sales tax using TaxCloud}
  s.description = %q{Calculate sales tax using the TaxCloud.net API}

  s.required_rubygems_version = '>= 1.3.6'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'savon', '0.9.6'

  # Development dependencies
  s.add_development_dependency 'rake', '>= 0.9.2'
  s.add_development_dependency 'rdoc', '>= 2.5.0'
  s.add_development_dependency 'vcr', '>= 1.11.3'
  s.add_development_dependency 'webmock', '>= 1.7.6'
end
