source 'https://rubygems.org'

gemspec

group :development do
  # Rubocop 0.41.2 is the lastest version to support
  # Ruby 1.9.3.
  gem 'rubocop', '~>0.41.2'
end

group :test do
  gem 'minitest'
  gem 'vcr'
  gem 'webmock'
end

group :development, :test do
  gem 'rake', '~>12.2.1'
  gem 'rdoc'
end
