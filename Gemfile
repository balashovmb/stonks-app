source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', '>= 1.12.0', require: false
gem 'cable_ready', '~> 5.0.pre9'
gem 'chartkick'
gem "cssbundling-rails"
gem "dry-monads"
gem 'devise'
gem 'jbuilder', '~> 2.7'
gem "jsbundling-rails"
gem 'pagy', '~> 5.10'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 7.0.3'
gem "redis", "~> 4.0"
gem 'sidekiq'
gem 'slim-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem "strong_migrations"
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'unicorn'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'bullet'
  gem 'capistrano', require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
  gem 'solargraph'
  # gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'action-cable-testing'
  gem 'capybara'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
  # gem 'webdrivers'
  gem 'webmock'
end
