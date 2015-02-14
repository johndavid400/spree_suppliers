source 'http://rubygems.org'

gem 'sqlite3'

group :test do
  gem 'rspec-rails'
end

group :cucumber do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'nokogiri'
  gem 'capybara'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end

gemspec
