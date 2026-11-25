# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development do
  gem 'rubocop', '~> 0.93.1'
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
