$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'tax_cloud/version'

Gem::Specification.new do |s|
  s.name        = 'tax_cloud'
  s.version     = TaxCloud::VERSION
  s.authors     = ['Drew Tempelmeyer']
  s.email       = ['drewtemp@gmail.com']
  s.homepage    = 'https://github.com/drewtempelmeyer/tax_cloud'
  s.summary     = 'Calculate sales tax using TaxCloud'
  s.description = 'Calculate sales tax using the TaxCloud.net API'
  s.licenses    = ['MIT']

  s.required_rubygems_version = '>= 1.3.6'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_runtime_dependency 'savon', '>= 2.0'
  s.add_runtime_dependency 'i18n'
  s.add_runtime_dependency 'activesupport', '>= 3.0'
end
