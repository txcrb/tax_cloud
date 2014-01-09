$:.push File.expand_path("../lib", __FILE__)
require "tax_cloud/version"

Gem::Specification.new do |s|
  s.name        = "tax_cloud"
  s.version     = TaxCloud::VERSION
  s.authors     = ["Drew Tempelmeyer"]
  s.email       = ["drewtemp@gmail.com"]
  s.homepage    = "https://github.com/drewtempelmeyer/tax_cloud"
  s.summary     = %q{Calculate sales tax using TaxCloud}
  s.description = %q{Calculate sales tax using the TaxCloud.net API}
  s.licenses    = ["MIT"]

  s.required_rubygems_version = '>= 1.3.6'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'savon', '>= 2.0'
  s.add_runtime_dependency 'i18n'
  s.add_runtime_dependency 'activesupport', '>= 3.0'

  s.add_development_dependency 'rake', '>= 0.9'
  s.add_development_dependency 'rdoc', '>= 2.5.0'
  s.add_development_dependency 'vcr', '~> 2.3'
  s.add_development_dependency 'webmock', '~> 1.8.0'
  s.add_development_dependency 'rubocop', '~> 0.16.0'
end
