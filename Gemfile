# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development do
  if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3')
    gem 'commonmarker', '~> 2.10', require: false
    gem 'rubocop', '~> 1.92'
    gem 'rubocop-md', '~> 3.0', require: false
    gem 'rubocop-prose', '~> 0.2', require: false
    gem 'rubocop-rake', '~> 0.7', require: false
    gem 'rubocop-spellcheck', '~> 0.2', require: false
    gem 'rubocop-yaml', '~> 0.1.0', require: false
    gem 'ruby-gem-release', '0.9.0', require: false
  end
end

group :test do
  gem 'minitest'
  # httpi 3.0.1, the newest httpi for Ruby < 3.0, does not support Rack 3.
  gem 'rack', '< 3' if RUBY_VERSION < '3.0'
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'rake'
end
