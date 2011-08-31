$:.push File.expand_path("../lib", __FILE__)
require "tax_cloud/version"

Gem::Specification.new do |s|
  s.name        = "tax_cloud"
  s.version     = TaxCloud::VERSION
  s.authors     = ["Drew Tempelmeyer"]
  s.email       = ["drewtemp@gmail.com"]
  s.homepage    = "https://github.com/drewtempelmeyer/tax_cloud"
  s.summary     = %q{Calculate sales tax using the TaxCloud.net API}
  s.description = %q{Calculate sales tax using the TaxCloud.net API}

  s.rubyforge_project = "tax_cloud"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<savon>, ['0.9.6'])

  # Development depencies
  s.add_development_dependency(%q<rake>, [">= 0.9.2"])
  s.add_development_dependency(%q<horo>, [">= 1.0.3"])
end
