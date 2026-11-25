# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'vcr'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/test_*.rb'
  test.verbose = false
end

load 'lib/tasks/tax_cloud.rake'
load 'lib/tasks/tax_codes.rake'
load 'lib/tasks/tax_code_groups.rake'
load 'vcr/tasks/vcr.rake'

lint = RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3') &&
       Gem.loaded_specs.key?('rubocop')
if lint
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)

  desc 'Lint Ruby, Markdown, YAML, and spelling'
  task lint: :rubocop
end

task default: lint ? %i[rubocop test] : %i[test]
